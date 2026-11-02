// Fetches a slot quote and submits appointment confirmation.
// A conflict is exposed with the requested patient-facing message.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/doctor_repository.dart';
import 'booking_event.dart';
import 'booking_state.dart';

/// Coordinates quote and booking requests.
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc(this._doctors, this._appointments, {required this.slotId})
    : super(const BookingState()) {
    on<BookingQuoteRequested>((e, emit) async {
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final quote = await _doctors.getQuote(e.slotId);
        emit(state.copyWith(status: FeatureStatus.success, quote: quote));
      } on ApiException catch (error) {
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            errorMessage: error.message,
          ),
        );
      }
    });
    on<BookingConfirmed>((e, emit) async {
      final slot = state.quote?.slotId ?? slotId;
      if (slot == null) {
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            errorMessage: 'Select an appointment time first.',
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          status: FeatureStatus.loading,
          clearError: true,
          slotTaken: false,
        ),
      );
      try {
        final appointment = await _appointments.book(
          slotId: slot,
          reason: e.reason,
        );
        emit(
          state.copyWith(
            status: FeatureStatus.success,
            appointment: appointment,
          ),
        );
      } on ApiException catch (error) {
        final taken = error.isConflict;
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            slotTaken: taken,
            errorMessage: taken
                ? 'This time was just booked by someone else, please pick another'
                : error.message,
          ),
        );
      }
    });
  }
  final DoctorRepository _doctors;
  final AppointmentRepository _appointments;
  final String? slotId;
}

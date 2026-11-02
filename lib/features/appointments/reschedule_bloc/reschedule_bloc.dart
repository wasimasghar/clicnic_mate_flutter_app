// Loads a new slot quote and confirms rescheduling for an appointment.
// Quote and reschedule requests use the existing doctor and appointment repositories.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/doctor_repository.dart';
import 'reschedule_event.dart';
import 'reschedule_state.dart';

/// Coordinates the reschedule quote and confirmation flow.
class RescheduleBloc extends Bloc<RescheduleEvent, RescheduleState> {
  RescheduleBloc(this._doctors, this._appointments)
    : super(const RescheduleState()) {
    on<RescheduleSlotChosen>((event, emit) async {
      emit(
        state.copyWith(
          status: FeatureStatus.loading,
          appointmentId: event.appointmentId,
          newSlotId: event.newSlotId,
          clearError: true,
          clearQuote: true,
        ),
      );
      try {
        final quote = await _doctors.getQuote(event.newSlotId);
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
    on<RescheduleConfirmed>((event, emit) async {
      final appointmentId = state.appointmentId;
      final newSlotId = state.newSlotId;
      if (appointmentId == null || newSlotId == null || state.quote == null) {
        return;
      }
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final appointment = await _appointments.reschedule(
          appointmentId: appointmentId,
          newSlotId: newSlotId,
        );
        emit(
          state.copyWith(
            status: FeatureStatus.success,
            appointment: appointment,
          ),
        );
      } on ApiException catch (error) {
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            errorMessage: error.message,
          ),
        );
      }
    });
  }
  final DoctorRepository _doctors;
  final AppointmentRepository _appointments;
}

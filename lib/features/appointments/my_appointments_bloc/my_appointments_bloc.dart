// Loads appointments, changes tabs, and cancels confirmed appointments.
// The appointment list reloads after a cancellation.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/appointment_repository.dart';
import 'my_appointments_event.dart';
import 'my_appointments_state.dart';

/// Coordinates the patient appointment list.
class MyAppointmentsBloc
    extends Bloc<MyAppointmentsEvent, MyAppointmentsState> {
  MyAppointmentsBloc(this._repository) : super(const MyAppointmentsState()) {
    on<MyAppointmentsRequested>(
      (event, emit) => _load(state.upcomingOnly, emit),
    );
    on<MyAppointmentsTabChanged>(
      (event, emit) => _load(event.upcomingOnly, emit),
    );
    on<AppointmentCancelRequested>((event, emit) async {
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        await _repository.cancel(event.appointmentId);
        await _load(state.upcomingOnly, emit);
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
  final AppointmentRepository _repository;
  Future<void> _load(
    bool upcomingOnly,
    Emitter<MyAppointmentsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FeatureStatus.loading,
        upcomingOnly: upcomingOnly,
        clearError: true,
      ),
    );
    try {
      final appointments = await _repository.getMyAppointments(
        upcomingOnly: upcomingOnly,
      );
      emit(
        state.copyWith(
          status: FeatureStatus.success,
          appointments: appointments,
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
  }
}

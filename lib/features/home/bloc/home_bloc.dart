// Loads specialties and the next patient appointment for the home screen.
// Independent requests run concurrently when a patient is signed in.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../data/models/specialty.dart';
import '../../../data/models/appointment.dart';
import 'home_event.dart';
import 'home_state.dart';

/// Coordinates home dashboard requests.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._doctors, this._appointments, this._auth)
    : super(const HomeState()) {
    on<HomeRequested>((e, emit) => _load(emit));
    on<HomeRefreshed>((e, emit) => _load(emit));
  }
  final DoctorRepository _doctors;
  final AppointmentRepository _appointments;
  final AuthRepository _auth;
  Future<void> _load(Emitter<HomeState> emit) async {
    emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
    try {
      final signedIn = await _auth.isSignedIn();
      final futures = await Future.wait<dynamic>([
        _doctors.getSpecialties(),
        if (signedIn) _appointments.getMyAppointments(upcomingOnly: true),
      ]);
      final appointments = signedIn
          ? futures[1] as List<Appointment>
          : const <Appointment>[];
      emit(
        state.copyWith(
          status: FeatureStatus.success,
          specialties: futures[0] as List<Specialty>,
          upcomingAppointment: appointments.isEmpty ? null : appointments.first,
          clearAppointment: appointments.isEmpty,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(status: FeatureStatus.failure, errorMessage: e.message),
      );
    }
  }
}

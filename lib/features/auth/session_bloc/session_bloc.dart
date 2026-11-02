// Restores, updates, and clears the patient authentication session.
// Token access stays inside AuthRepository and TokenStorage.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/auth_repository.dart';
import 'session_event.dart';
import 'session_state.dart';

/// Owns application-wide signed-in state.
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc(this._authRepository) : super(const SessionState()) {
    on<SessionStarted>((event, emit) async {
      emit(state.copyWith(status: FeatureStatus.loading));
      final signedIn = await _authRepository.isSignedIn();
      emit(state.copyWith(status: FeatureStatus.success, isSignedIn: signedIn));
    });
    on<SessionSignedIn>(
      (event, emit) => emit(
        state.copyWith(
          status: FeatureStatus.success,
          isSignedIn: true,
          clearError: true,
        ),
      ),
    );
    on<SessionSignedOut>((event, emit) async {
      await _authRepository.signOut();
      emit(const SessionState(status: FeatureStatus.success));
    });
    on<SessionExpired>((event, emit) async {
      await _authRepository.signOut();
      emit(
        const SessionState(
          status: FeatureStatus.failure,
          errorMessage: 'Please sign in again',
        ),
      );
    });
  }
  final AuthRepository _authRepository;
}

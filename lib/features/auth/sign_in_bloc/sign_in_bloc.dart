// Submits sign-in credentials and updates the shared session on success.
// API exceptions are exposed as readable state messages.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/auth_repository.dart';
import '../session_bloc/session_bloc.dart';
import '../session_bloc/session_event.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

/// Handles the sign-in form submission lifecycle.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._repository, this._sessionBloc) : super(const SignInState()) {
    on<SignInSubmitted>((event, emit) async {
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final result = await _repository.signIn(
          phone: event.phone,
          password: event.password,
        );
        emit(
          state.copyWith(
            status: FeatureStatus.success,
            patient: result.patient,
          ),
        );
        _sessionBloc.add(const SessionSignedIn());
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
  final AuthRepository _repository;
  final SessionBloc _sessionBloc;
}

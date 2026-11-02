// Runs the sign-up OTP and account creation workflow.
// Repository failures are emitted as readable form state.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/auth_repository.dart';
import '../session_bloc/session_bloc.dart';
import '../session_bloc/session_event.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

/// Handles registration details, verification, and resend actions.
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._repository, this._sessionBloc) : super(const SignUpState()) {
    on<SignUpDetailsSubmitted>((event, emit) async {
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final response = await _repository.sendOtp(event.phone);
        if (response['sent'] != true) {
          emit(
            state.copyWith(
              status: FeatureStatus.failure,
              errorMessage:
                  response['message'] as String? ??
                  'Unable to send a verification code.',
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            status: FeatureStatus.success,
            phone: event.phone,
            username: event.username,
            dateOfBirth: event.dateOfBirth,
            bio: event.bio,
            password: event.password,
            otpSent: true,
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
    on<SignUpOtpSubmitted>((event, emit) async {
      if (state.phone == null ||
          state.username == null ||
          state.dateOfBirth == null ||
          state.password == null) {
        return;
      }
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final result = await _repository.signUp(
          phone: state.phone!,
          username: state.username!,
          dateOfBirth: state.dateOfBirth!,
          bio: state.bio,
          password: state.password!,
          otp: event.otp,
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
    on<SignUpOtpResent>((event, emit) async {
      if (state.phone == null) return;
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final response = await _repository.sendOtp(state.phone!);
        if (response['sent'] == true) {
          emit(state.copyWith(status: FeatureStatus.success, otpSent: true));
        } else {
          emit(
            state.copyWith(
              status: FeatureStatus.failure,
              errorMessage:
                  response['message'] as String? ??
                  'Unable to send a verification code.',
            ),
          );
        }
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

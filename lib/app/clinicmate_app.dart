// Root MaterialApp for ClinicMate. Applies AppTheme and the route table.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_colors.dart';
import '../core/network/feature_status.dart';
import 'app_routes.dart';
import 'app_dependencies.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/doctor_repository.dart';
import '../data/repositories/appointment_repository.dart';
import '../data/repositories/waiting_list_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../features/auth/session_bloc/session_bloc.dart';
import '../features/auth/session_bloc/session_event.dart';
import '../features/auth/session_bloc/session_state.dart';

/// Provides repositories and session state around the ClinicMate application.
class ClinicMateApp extends StatelessWidget {
  const ClinicMateApp({super.key, required this.dependencies});

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(
          value: dependencies.authRepository,
        ),
        RepositoryProvider<DoctorRepository>.value(
          value: dependencies.doctorRepository,
        ),
        RepositoryProvider<AppointmentRepository>.value(
          value: dependencies.appointmentRepository,
        ),
        RepositoryProvider<WaitingListRepository>.value(
          value: dependencies.waitingListRepository,
        ),
        RepositoryProvider<ProfileRepository>.value(
          value: dependencies.profileRepository,
        ),
        RepositoryProvider<ChatRepository>.value(
          value: dependencies.chatRepository,
        ),
      ],
      child: BlocProvider<SessionBloc>(
        create: (context) {
          final bloc = SessionBloc(context.read<AuthRepository>());
          dependencies.onUnauthorized = () => bloc.add(const SessionExpired());
          bloc.add(const SessionStarted());
          return bloc;
        },
        child: BlocListener<SessionBloc, SessionState>(
          listenWhen: (previous, current) =>
              current.errorMessage == 'Please sign in again' ||
              (previous.isSignedIn &&
                  !current.isSignedIn &&
                  current.status == FeatureStatus.success),
          listener: (context, state) {
            _navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.signIn,
              (_) => false,
            );
            final navigatorContext = _navigatorKey.currentContext;
            if (navigatorContext != null &&
                state.errorMessage == 'Please sign in again') {
              ScaffoldMessenger.of(navigatorContext).showSnackBar(
                const SnackBar(content: Text('Please sign in again')),
              );
            }
          },
          child: MaterialApp(
            navigatorKey: _navigatorKey,
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            builder: (context, child) => ColoredBox(
              color: AppColors.background,
              child: child ?? const SizedBox.shrink(),
            ),
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
          ),
        ),
      ),
    );
  }
}

// Shows the welcome splash briefly, then routes based on the restored session.
// The restored session decides whether home or sign-in opens next.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/feature_status.dart';
import '../../auth/session_bloc/session_bloc.dart';
import '../../auth/session_bloc/session_state.dart';
import 'splash_screen.dart';

/// Keeps the splash visible before opening home or sign-in automatically.
class StartupSplashGate extends StatefulWidget {
  const StartupSplashGate({
    super.key,
    required this.homeRoute,
    required this.signInRoute,
  });

  final String homeRoute;
  final String signInRoute;

  @override
  State<StartupSplashGate> createState() => _StartupSplashGateState();
}

class _StartupSplashGateState extends State<StartupSplashGate> {
  static const Duration _splashDuration = Duration(milliseconds: 2500);

  Timer? _splashTimer;
  bool _splashFinished = false;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _splashTimer = Timer(_splashDuration, () {
      if (!mounted) return;
      setState(() => _splashFinished = true);
      _navigateWhenReady(context.read<SessionBloc>().state);
    });
  }

  void _navigateWhenReady(SessionState session) {
    if (_hasNavigated) return;
    final sessionReady = session.status == FeatureStatus.success ||
        session.status == FeatureStatus.failure;
    if (!_splashFinished || !sessionReady) return;

    _openDestination(session);
  }

  void _openDestination(SessionState session) {
    if (_hasNavigated) return;
    _hasNavigated = true;
    final destination = session.isSignedIn ? widget.homeRoute : widget.signInRoute;
    Navigator.of(context).pushReplacementNamed(destination);
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<SessionBloc, SessionState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.isSignedIn != current.isSignedIn,
        listener: (context, session) => _navigateWhenReady(session),
        child: const SplashScreen(),
      );
}

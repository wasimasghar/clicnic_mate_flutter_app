// App entry point. Creates the app dependencies and starts ClinicMate.
// In debug builds it prints which backend URL this build uses (set with --dart-define-from-file).

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app_dependencies.dart';
import 'app/clinicmate_app.dart';
import 'core/config/app_config.dart';

void main() {
  if (kDebugMode) {
    debugPrint('ClinicMate backend: ${AppConfig.baseUrl}');
  }
  final dependencies = AppDependencies();
  runApp(ClinicMateApp(dependencies: dependencies));
}

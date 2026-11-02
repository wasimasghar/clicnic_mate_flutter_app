// Smoke test that ClinicMate launches on the theme preview screen.

import 'package:flutter_test/flutter_test.dart';

import 'package:doc_mate/app/clinicmate_app.dart';
import 'package:doc_mate/app/app_dependencies.dart';
import 'package:doc_mate/core/constants/app_strings.dart';

void main() {
  testWidgets('Theme preview screen is shown on launch', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(ClinicMateApp(dependencies: AppDependencies()));
    await tester.pump();

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.getStarted), findsOneWidget);
  });
}

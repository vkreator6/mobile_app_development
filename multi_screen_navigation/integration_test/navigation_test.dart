import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_trail/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('return data, preserve saved state on cancel, and unwind stack', (
    tester,
  ) async {
    await tester.pumpWidget(const StudyTrailApp());
    Future<void> tap(String label) async {
      await tester.scrollUntilVisible(
        find.text(label),
        160,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.ensureVisible(find.text(label));
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }

    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await binding.takeScreenshot('01_home');
    await tap('Explore Flutter navigation');
    await binding.takeScreenshot('02_details');
    await tap('Plan a session');
    expect(find.text('Studying: Flutter navigation'), findsOneWidget);
    await tap('45 minutes');
    await binding.takeScreenshot('03_planner');
    await tap('Save session');
    await binding.takeScreenshot('04_returned_result');
    expect(find.text('Session saved: 45 minutes'), findsOneWidget);
    await tap('Edit session');
    await tap('15 minutes');
    await tap('Cancel and go back');
    expect(find.text('Session saved: 45 minutes'), findsOneWidget);
    await tap('Edit session');
    expect(
      tester
          .widget<ChoiceChip>(find.widgetWithText(ChoiceChip, '45 minutes'))
          .selected,
      isTrue,
    );
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Session saved: 45 minutes'), findsOneWidget);
    await tap('Back to topics');
    expect(find.text('Study Trail'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
    await tap('Explore Stateful widgets');
    await tap('Plan a session');
    expect(find.text('Studying: Stateful widgets'), findsOneWidget);
    await tap('Cancel and go back');
    expect(find.text('Your session awaits'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Study Trail'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gesture_controlled_interface/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('tap, swipe, and long press update the interface', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    final card = find.text('Gesture card');
    await tester.tap(card);
    await tester.pumpAndSettle();
    expect(find.text('Taps: 1     Swipes: 0'), findsOneWidget);

    await tester.drag(card, const Offset(-280, 0));
    await tester.pumpAndSettle();
    expect(find.text('Taps: 1     Swipes: 1'), findsOneWidget);
    expect(find.textContaining('Swipe left detected'), findsOneWidget);

    await tester.drag(card, const Offset(280, 0));
    await tester.pumpAndSettle();
    expect(find.text('Taps: 1     Swipes: 2'), findsOneWidget);
    expect(find.textContaining('Swipe right detected'), findsOneWidget);

    await tester.longPress(card);
    await tester.pumpAndSettle();
    expect(find.text('Taps: 0     Swipes: 0'), findsOneWidget);
  });
}

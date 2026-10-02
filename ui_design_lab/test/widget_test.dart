import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_design_lab/main.dart';

void main() {
  testWidgets('navigate, increment, reset, and return home', (tester) async {
    await tester.pumpWidget(const LabApp());
    expect(find.text('Welcome!'), findsOneWidget);
    await tester.tap(find.text('Open counter'));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Add one'));
      await tester.pump();
    }
    expect(find.text('3'), findsOneWidget);
    expect(find.text('The counter has updated!'), findsOneWidget);
    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Tap the button to begin.'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Welcome!'), findsOneWidget);
  });
}

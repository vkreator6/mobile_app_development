# Testing and troubleshooting

Tested November 1, 2026 using Flutter 3.47.5 / Dart 3.13.4 and the Ass3_Pixel Android emulator (Android 15, API 35, arm64).

## Results

- `flutter analyze`: no issues found (see analysis.txt).
- `flutter test`: navigation scenario passed (see widget-test.txt).
- `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/navigation_test.dart -d emulator-5554`: passed on the emulator (see emulator-test.txt).
- Four real Flutter-surface screenshots captured by the emulator integration test and visually inspected. They omit Android system chrome by design.

| Path / behavior | Result |
| --- | --- |
| Home → Flutter navigation details | Pass |
| Details → Planner with correct topic | Pass |
| Select 45 minutes → Save → Details shows 45 | Pass |
| Edit → select 15 → Cancel → saved 45 remains | Pass |
| Reopen Planner → saved 45 is selected | Pass |
| App-bar back from Planner → saved Details state remains | Pass |
| Back to topics → Home without a duplicate back button | Pass |
| Home → Stateful widgets → Planner receives second topic | Pass |
| Cancel without an existing plan → Details remains unsaved | Pass |
| App-bar back from Details → Home | Pass |

The default selection is 25 minutes. The test changes to 45 for saving and 15 for cancellation. Android system back gestures and iOS execution were not separately tested; the tested backward paths use the app-bar and explicit buttons.

## Navigation issue: cancel overwrites a saved result

This was deliberately reproduced in a temporary copy of the app to validate the protective handler; it was not an unplanned failure in the final app.

1. Open the first topic and save 45 minutes.
2. Reopen the planner and select 15 minutes.
3. Cancel, which pops the route without a result (null).
4. In the faulty handler, `setState(() => minutes = result)` runs on null and erases the saved plan.
5. The regression test fails because `Session saved: 45 minutes` disappears.

Faulty guard:

```dart
if (!mounted) return;
setState(() => minutes = result);
```

Corrected guard in the delivered app:

```dart
if (!mounted || result == null) return;
setState(() => minutes = result);
```

The expected failing log is preserved in `cancel-issue-reproduction.txt`. The temporary faulty copy was removed. The same scenario passes against the delivered implementation in both widget and emulator tests.

## Additional troubleshooting

The first widget test used `ensureVisible` before a lazily built ListView child existed. It failed with `Bad state: No element`. The helper now calls `scrollUntilVisible` before locating and tapping the navigation action, so tests work on the smaller default test viewport as well as the emulator.

The standard emulator launch did not leave a connected device, so the emulator executable was launched directly with the existing AVD. The Android build emitted SDK XML-version and predictive-back opt-in warnings; these did not prevent the tested navigation paths from passing. No SDK upgrades were needed.

## Screenshot sequence

1. `screenshots/01_home.png` — choose a topic.
2. `screenshots/02_details.png` — topic passed from Home.
3. `screenshots/03_planner.png` — topic received; 45 minutes selected.
4. `screenshots/04_returned_result.png` — returned result displayed on the existing Details route.

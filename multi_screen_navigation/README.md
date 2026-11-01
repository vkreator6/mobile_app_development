# Study Trail — Multi-Screen Navigation Lab

A Flutter app with three screens and typed route results. No backend or account is required.

## Run

With Flutter installed and an Android emulator or phone connected:

```sh
flutter pub get
flutter run
```

Select the Android device if prompted. Source for all three screens is in `lib/main.dart`.

## Navigation

```text
Home → Topic Details → Session Planner
Home ← Topic Details ← Session Planner (save returns minutes; cancel returns null)
```

Home pushes Details with a `StudyTopic` constructor argument. Details pushes Planner with the same topic and current duration. Planner saves with `Navigator.pop<int>(context, selectedMinutes)`. Details awaits the result and updates only when it is non-null and the widget remains mounted. App-bar back arrows and clearly labeled back/cancel buttons pop existing routes.

Session state is local to the Details route. It survives planner visits but is intentionally reset after leaving Details and opening a new topic; it is not persisted across app restarts.

## Validation

```sh
flutter analyze
flutter test
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/navigation_test.dart -d emulator-5554
```

Replace `emulator-5554` with the ID reported by `flutter devices`. The integration driver saves actual emulator-rendered screenshots in `submission/screenshots/`.

The test covers both topics, forward data, all three duration choices, saving, explicit cancel, app-bar back, restoring the saved selection, and returning to the root without a duplicate route. See `submission/testing.md` for results and troubleshooting.

## Submission files

- `submission/reflection.md`: 300–400 word reflection, with APA-style references.
- `submission/screenshots/`: four numbered captures of the navigation flow.
- `submission/testing.md`: test environment, paths checked, and issue reproduction.
- `submission/*test.txt`: execution evidence.

The Chapter 6 text was not supplied, so the reflection cites the official Flutter documentation rather than attributing claims to unavailable course material.

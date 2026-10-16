# Gesture-Controlled Interface

This Flutter app demonstrates three gestures on one card: tap changes its color, a horizontal swipe updates the swipe count and direction message, and a long press resets the card and counts. The card gives animated visual changes and haptic feedback.

Run on Android or use the Mac mouse/trackpad in Chrome:

```sh
flutter pub get
flutter run -d emulator-5554
flutter run -d chrome
```

For a native macOS window, run `flutter run -d macos` on a Mac with Xcode installed. The project includes the macOS runner; this machine does not have Xcode, so I verified Mac mouse and trackpad input in Chrome.

Run the Android gesture checks with an attached emulator:

```sh
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/gesture_test.dart
```

The 300–400 word reflection is in `submission/reflection.txt`. Android emulator screenshots are in `submission/screenshots/`.

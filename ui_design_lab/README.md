# Flutter UI Lab

Run with `flutter pub get` and `flutter run` on an Android emulator or device.
Run checks with `flutter analyze` and `flutter test`.

The app has two screens. HomeScreen extends StatelessWidget because it displays fixed welcome content and does not store changing local data. It uses Scaffold, AppBar, Column, Icon, Text, and a FilledButton. The button opens CounterScreen through Navigator and MaterialPageRoute. The app bar on the second screen provides back navigation.

CounterScreen extends StatefulWidget and keeps an integer counter in its State object. Pressing Add one increments the counter inside setState, which tells Flutter to rebuild the UI and display the updated number and message. Reset sets the counter back to zero and restores the initial message. The counter is held in memory for that screen; opening it again starts at zero.

Screenshots in submission/screenshots show the home screen and the counter before and after interaction.

Verified on the Ass3_Pixel Android emulator: open counter, increment from 0 to 3, reset to 0, and return home. Flutter analysis and the widget interaction test also passed.

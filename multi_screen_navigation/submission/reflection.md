# Multi-Screen Navigation Reflection

Study Trail is a small Flutter application that helps users choose a learning topic and plan a study session. It contains three distinct screens: Home, Topic Details, and Session Planner. The navigation structure uses Flutter’s Navigator and MaterialPageRoute. Each forward action pushes a route onto the stack, and each backward action pops the current route. This structure keeps the previous screen available underneath the active screen and follows Flutter’s documented approach to basic navigation (Flutter, n.d.-b).

Users begin on Home, where clearly labeled Explore buttons open the details for either Flutter navigation or stateful widgets. The selected StudyTopic object is passed through the Details screen’s constructor. On that screen, the user can read a short description and select Plan a session. The planner receives the topic and the current duration, so its heading identifies the correct topic and its selection reflects any saved plan. Users choose 15, 25, or 45 minutes and press Save session to return to Details.

Saving demonstrates data traveling backward through the navigation stack. Navigator.pop returns an integer, and the Details screen awaits that result before displaying the saved duration (Flutter, n.d.-c). Cancel and the app-bar back arrow return without saving. The explicit Back to topics button removes Details and reveals Home. These labels make the available actions understandable without requiring users to know how routing works.

During troubleshooting, a controlled regression reproduced a navigation-result issue: allowing a canceled planner route’s null result to overwrite the saved duration erased the previous plan. The test saved 45 minutes, reopened the planner, selected 15 minutes, and canceled. Without the null guard, the expected 45-minute confirmation disappeared. The corrected handler ignores null results and checks mounted before updating state, consistent with Flutter’s guidance on returning route data (Flutter, n.d.-a, n.d.-d).

Validation included automated widget tests and an integration run on an Android emulator. The tests exercised both topics, saving, canceling, app-bar back navigation, and returning to the root. Screenshots record Home, Details, Planner, and the returned result. This exercise reinforced that reliable navigation involves both managing the route stack and deciding precisely when returned data should change existing screen state.

## References

Flutter. (n.d.-a). *mounted property*. https://api.flutter.dev/flutter/widgets/State/mounted.html

Flutter. (n.d.-b). *Navigate to a new screen and back*. https://docs.flutter.dev/cookbook/navigation/navigation-basics

Flutter. (n.d.-c). *pop<T extends Object?> static method*. https://api.flutter.dev/flutter/widgets/Navigator/pop.html

Flutter. (n.d.-d). *Return data from a screen*. https://docs.flutter.dev/cookbook/navigation/returning-data

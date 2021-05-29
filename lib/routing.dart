import 'package:flutter/material.dart';
import 'main.dart';
import 'journalinput.dart';
import 'profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    const String homeId = '/';
    const String jouranlInputId = '/journalInput';
    const String profileId = '/profile';

    switch (settings.name) {
      case homeId:
        return MaterialPageRoute(builder: (context) => Home());
      case jouranlInputId:
        final args = settings.arguments as JournalInputArguments;
        return MaterialPageRoute(
            builder: (context) => JournalInput(journalText: args.journalText));
      case profileId:
        return MaterialPageRoute(builder: (context) => Profile());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapwork_assignment/src/app/ui/create_event.dart';
import 'package:snapwork_assignment/src/app/ui/events_screen.dart';

class Routes {
  static const events = 'events';
  static const createEvents = 'createEvents';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case events:
        return CupertinoPageRoute(
            builder: (_) => const EventsScreen(), title: 'Events');
      case createEvents:
        return CupertinoPageRoute(
            builder: (_) => const CreateEvent(), title: 'Event Detail');
      default:
        return MaterialPageRoute(builder: (_) => const EventsScreen());
    }
  }
}

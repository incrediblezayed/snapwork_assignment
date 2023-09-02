import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapwork_assignment/src/app/app.dart';
import 'package:snapwork_assignment/src/app/providers/app_providers.dart';
import 'package:snapwork_assignment/src/app/repository/event_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [
    eventRepository.overrideWithValue(
        EventRepository(sharedPreferences: sharedPreferences))
  ], child: const AssignmentApp()));
}

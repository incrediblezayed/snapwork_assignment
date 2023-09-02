import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapwork_assignment/src/app/models/event_model.dart';

class EventRepository {
  final SharedPreferences _sharedPreferences;
  EventRepository({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;
  final _events = 'events';
  Future<void> updateEvents(List<EventModel> events) async {
    await _sharedPreferences.setStringList(
        _events, events.map((e) => e.toJson()).toList());
  }

  List<EventModel> getEvents() {
    List<String>? events = _sharedPreferences.getStringList(_events);
    if (events == null) {
      return [];
    }
    return events.map((e) => EventModel.fromJson(e)).toList();
  }
}

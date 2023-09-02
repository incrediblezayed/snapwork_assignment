import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapwork_assignment/src/app/providers/event_provider.dart';
import 'package:snapwork_assignment/src/app/repository/event_repository.dart';

final eventRepository =
    Provider<EventRepository>((ref) => throw UnimplementedError());

final eventProvider = ChangeNotifierProvider(EventProvider.new);


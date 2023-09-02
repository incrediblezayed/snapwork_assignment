import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:snapwork_assignment/src/app/models/event_model.dart';
import 'package:snapwork_assignment/src/app/providers/app_providers.dart';
import 'package:snapwork_assignment/src/app/repository/event_repository.dart';

class EventProvider extends ChangeNotifier {
  final Ref ref;
  EventProvider(this.ref) {
    getEvents();
  }

  late final EventRepository _repository = ref.read(eventRepository);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<int> dates = [];

  DateTime? pickedDateTime;

  int? month;

  int? year;

  String? pickedTime;

  String? monthText;

  List<EventModel> events = [];

  EventModel? currentEventModel;

  void editEvent() {
    if (currentEventModel != null) {
      titleController.text = currentEventModel!.title;
      descriptionController.text = currentEventModel!.description;
      pickedDateTime = currentEventModel!.dateTime;
      pickedTime = getTimeTextFromDateTime();
      notifyListeners();
    } else {
      titleController.clear();
      descriptionController.clear();
      pickedTime = null;
      notifyListeners();
    }
  }

  void updateEvent(void Function() pop) async {
    int indexOfEvent =
        events.indexWhere((element) => element == currentEventModel);
    if (indexOfEvent != -1) {
      events[indexOfEvent] = EventModel(
          title: titleController.text,
          description: descriptionController.text,
          dateTime: pickedDateTime!);
      _repository.updateEvents(events);
      pop();
      await Future.delayed(const Duration(milliseconds: 500));
      titleController.clear();
      descriptionController.clear();
      pickedDateTime = null;
      currentEventModel = null;
      notifyListeners();
    }
  }

  String getMonthByIndex(int index, [String format = 'MMMM']) {
    return DateFormat(format).format(DateTime(9, index));
  }

  void selectMonth(BuildContext context) async {
    int? selectedMonth = await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('Select Month'),
          actions: List.generate(12, (index) => index + 1).map((e) {
            return CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context, e);
                },
                child: Text(getMonthByIndex(e)));
          }).toList(),
        );
      },
    );
    if (selectedMonth != null) {
      month = selectedMonth;
      monthText = getMonthByIndex(selectedMonth);
      if (year != null) {
        dates = List.generate(DateUtils.getDaysInMonth(year!, selectedMonth),
            (index) => index + 1);
      }
      notifyListeners();
    }
  }

  void selectYear(BuildContext context) async {
    int? value = await showCupertinoModalPopup<int>(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('Select Year'),
          actions: List.generate(15, (index) => index + 2016)
              .map((e) => CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop<int>(context, e);
                    },
                    isDefaultAction: true,
                    child: Text(e.toString()),
                  ))
              .toList(),
        );
      },
    );
    if (value != null) {
      year = value;
      if (month != null) {
        dates = List.generate(
            DateUtils.getDaysInMonth(value, month!), (index) => index + 1);
      }
      notifyListeners();
    }
  }

  void pickTime(BuildContext context) async {
    var pickedTime = await showCupertinoModalPopup<DateTime>(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      context: context,
      builder: (context) {
        DateTime time = DateTime.now();
        return Container(
          height: MediaQuery.sizeOf(context).height / 2,
          color: CupertinoColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.pop(context, time);
                      }),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (value) {
                    time = value;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pickedTime != null) {
      pickedDateTime = pickedDateTime!
          .copyWith(hour: pickedTime.hour, minute: pickedTime.minute);
      this.pickedTime = getTimeTextFromDateTime();
      notifyListeners();
    }
  }

  String? getTimeTextFromDateTime() {
    if (pickedDateTime == null) {
      return null;
    }
    var time = DateFormat('hh:mm').format(pickedDateTime!);
    return time;
  }

  Future<void> getEvents() async {
    events = _repository.getEvents();
    notifyListeners();
  }

  Future<void> createEvent(void Function() pop) async {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        pickedDateTime != null) {
      if (currentEventModel != null) {
        updateEvent(pop);
      } else {
        EventModel event = EventModel(
            title: titleController.text,
            description: descriptionController.text,
            dateTime: pickedDateTime!);
        events.add(event);
        pop();
        await Future.delayed(const Duration(milliseconds: 500));
        _repository.updateEvents(events);
        titleController.clear();
        descriptionController.clear();
        pickedDateTime = null;
        notifyListeners();
      }
    }
  }

  EventModel? getEventOfDate(int date) {
    return events.firstWhereOrNull(
      (element) =>
          DateUtils.isSameDay(element.dateTime, DateTime(year!, month!, date)),
    );
  }
}

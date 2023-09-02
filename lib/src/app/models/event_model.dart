// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventModel {
  final String title;
  final String description;
  final DateTime dateTime;
  EventModel({
    required this.title,
    required this.description,
    required this.dateTime,
  });

  EventModel copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
  }) {
    return EventModel(
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'time': dateTime.millisecondsSinceEpoch,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      title: map['title'] as String,
      description: map['description'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EventModel(title: $title, description: $description, time: $dateTime)';

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ dateTime.hashCode;
}

import 'package:panda_frontend/events/types/event_type.dart';

class EventInfo {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String organizer;
  final EventType? eventType;
  final DateTime? updatedAt;

  EventInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.organizer,
    this.eventType,
    this.updatedAt,
  });

  EventInfo copyWith({
    final String? id,
    final String? title,
    final String? description,
    final DateTime? date,
    final String? location,
    final String? organizer,
    final EventType? eventType,
    final DateTime? updatedAt,
  }) {
    return EventInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      location: location ?? this.location,
      organizer: organizer ?? this.organizer,
      eventType: eventType ?? this.eventType,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  EventInfo.fromMap(Map json)
      : id = json['id'].toString(),
        title = json['title'].toString(),
        description = json['description'].toString(),
        date = DateTime.parse(json['date']),
        location = json['location'].toString(),
        organizer = json['organizer'].toString(),
        eventType = EventType.fromString(json['eventType'].toString()),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'organizer': organizer,
      'eventType': eventType?.type,
    };
  }
}

import 'package:collection/collection.dart';

enum EventType {
  all('All', 'ALL'),
  conference('Conference', 'CONFERENCE'),
  workshop('Workshop', 'WORKSHOP'),
  webinar('Webinar', 'WEBINAR');

  final String label;
  final String type;

  const EventType(this.label, this.type);

  static EventType? fromString(String value) {
    return values.firstWhereOrNull((e) => e.type == value);
  }
}

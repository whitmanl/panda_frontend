import 'package:flutter/cupertino.dart';
import 'package:panda_frontend/common/helpers/api_helper.dart';

// Project imports:

import 'package:panda_frontend/common/stores/roots_store.dart';
import 'package:panda_frontend/common/stores/types/event_info.dart';
import 'package:panda_frontend/events/types/event_type.dart';

class EventsStore extends ChangeNotifier {
  final RootStore rootStore;
  EventsStore(this.rootStore);

  List<EventInfo> events = [];
  EventInfo? selectedEvent;
  EventType? selectedEventType;

  Future<void> getEvents(BuildContext context) async {
    final res = await ApiHelper.get(
      context,
      path: '/events',
      queryParameters:
          selectedEventType != null && selectedEventType != EventType.all
              ? {
                  'eventType': selectedEventType?.type,
                }
              : {},
    );

    events = res.map<EventInfo>((v) => EventInfo.fromMap(v)).toList();
    notifyListeners();
  }

  Future<void> getEventById(
    BuildContext context, {
    required String id,
  }) async {
    final res = await ApiHelper.get(
      context,
      path: '/events/$id',
    );
    selectedEvent = EventInfo.fromMap(res);
    notifyListeners();
  }

  Future<void> addEvent(
    BuildContext context, {
    required EventInfo event,
  }) async {
    await ApiHelper.post(
      context,
      path: '/events',
      body: event.toJson(),
    );
    if (!context.mounted) return;
    getEvents(context);
  }

  Future<void> updateEvent(
    BuildContext context, {
    required EventInfo event,
  }) async {
    await ApiHelper.put(
      context,
      path: '/events/${event.id}',
      body: event.toJson(),
    );
    if (!context.mounted) return;
    getEvents(context);
    await getEventById(context, id: event.id);
  }

  Future<void> deleteEvent(
    BuildContext context, {
    required EventInfo event,
  }) async {
    await ApiHelper.delete(
      context,
      path: '/events/${event.id}',
    );
    if (!context.mounted) return;
    getEvents(context);
  }
}

// Flutter imports:

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:panda_frontend/common/stores/events_store.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final String id;

  const EventDetailsScreen({super.key, required this.id});

  @override
  EventDetailsScreenState createState() => EventDetailsScreenState();
}

class EventDetailsScreenState extends State<EventDetailsScreen>
    with AfterLayoutMixin {
  Future<void> _onDelete() async {
    EventsStore eventsStore = context.read<EventsStore>();
    try {
      await eventsStore.deleteEvent(context, event: eventsStore.selectedEvent!);
      if (!mounted) return;
      context.pop();
    } catch (_) {}
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    EventsStore eventsStore = context.read<EventsStore>();
    await eventsStore.getEventById(context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    EventsStore eventsStore = context.watch<EventsStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: eventsStore.selectedEvent == null
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title: ${eventsStore.selectedEvent?.title}"),
                  Text(
                      "Description: ${eventsStore.selectedEvent?.description}"),
                  Text("Date: ${eventsStore.selectedEvent?.date}"),
                  Text("Location: ${eventsStore.selectedEvent?.location}"),
                  Text("Organizer: ${eventsStore.selectedEvent?.organizer}"),
                  Text("Type: ${eventsStore.selectedEvent?.eventType?.label}"),
                  Text("Updated At: ${eventsStore.selectedEvent?.updatedAt}"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.push(
                              '/create-edit-details?id=${eventsStore.selectedEvent?.id}'),
                          child: const Text("Edit Event"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _onDelete,
                          child: const Text("Delete Event"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

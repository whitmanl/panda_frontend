// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:panda_frontend/common/stores/events_store.dart';
import 'package:panda_frontend/common/stores/types/event_info.dart';
import 'package:panda_frontend/events/types/event_type.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  EventsScreenState createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    EventsStore eventsStore = context.watch<EventsStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            onPressed: () {
              eventsStore.selectedEvent = null;
              context.push('/create-edit-details');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          DropdownButton<EventType>(
            value: eventsStore.selectedEventType,
            hint: const Text('Filter by Event Type'),
            items: EventType.values
                .map(
                  (eventType) => DropdownMenuItem(
                    value: eventType,
                    child: Text(eventType.label),
                  ),
                )
                .toList(),
            onChanged: (newValue) async {
              eventsStore.selectedEventType = newValue;
              await eventsStore.getEvents(context);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: eventsStore.events.length,
              itemBuilder: (context, index) {
                final EventInfo event = eventsStore.events[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.description),
                  onTap: () => context.push('/event-details?id=${event.id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

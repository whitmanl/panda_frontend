// Flutter imports:

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:panda_frontend/common/stores/events_store.dart';
import 'package:panda_frontend/common/stores/types/event_info.dart';
import 'package:panda_frontend/events/types/event_type.dart';
import 'package:provider/provider.dart';

class CreateEditDetailsScreen extends StatefulWidget {
  const CreateEditDetailsScreen({
    super.key,
  });

  @override
  CreateEditDetailsScreenState createState() => CreateEditDetailsScreenState();
}

class CreateEditDetailsScreenState extends State<CreateEditDetailsScreen>
    with AfterLayoutMixin {
  final TextEditingController _titleController =
      TextEditingController(text: '');
  final TextEditingController _descriptionController =
      TextEditingController(text: '');
  final TextEditingController _locationController =
      TextEditingController(text: '');
  final TextEditingController _organizerController =
      TextEditingController(text: '');
  EventType? selectedEventType;
  DateTime selectedDate = DateTime.now();

  Future<void> _onSave() async {
    EventsStore eventsStore = context.read<EventsStore>();
    try {
      await eventsStore.addEvent(
        context,
        event: EventInfo(
          id: "",
          title: _titleController.text,
          description: _descriptionController.text,
          date: selectedDate,
          location: _locationController.text,
          organizer: _organizerController.text,
          eventType: selectedEventType!,
        ),
      );
      if (!mounted) return;
      context.pop();
    } catch (_) {}
  }

  Future<void> _onEdit() async {
    EventsStore eventsStore = context.read<EventsStore>();
    try {
      await eventsStore.updateEvent(
        context,
        event: eventsStore.selectedEvent!.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
          date: selectedDate,
          location: _locationController.text,
          organizer: _organizerController.text,
          eventType: selectedEventType!,
        ),
      );
      if (!mounted) return;
      context.pop();
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    for (TextEditingController e in [
      _titleController,
      _descriptionController,
      _locationController,
      _organizerController
    ]) {
      e.addListener(triggerUpdate);
    }
  }

  @override
  void dispose() {
    for (TextEditingController e in [
      _titleController,
      _descriptionController,
      _locationController,
      _organizerController
    ]) {
      e.removeListener(triggerUpdate);
    }
    super.dispose();
  }

  void triggerUpdate() => setState(() {});

  @override
  void afterFirstLayout(BuildContext context) async {
    EventsStore eventsStore = context.read<EventsStore>();
    _titleController.text = eventsStore.selectedEvent?.title ?? '';
    _descriptionController.text = eventsStore.selectedEvent?.description ?? '';
    _locationController.text = eventsStore.selectedEvent?.location ?? '';
    _organizerController.text = eventsStore.selectedEvent?.organizer ?? '';
    selectedEventType = eventsStore.selectedEvent?.eventType;
    selectedDate = eventsStore.selectedEvent?.date ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    EventsStore eventsStore = context.watch<EventsStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            eventsStore.selectedEvent == null ? 'Create Event' : 'Edit Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
            ),
            GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  initialDateTime: selectedDate,
                  pickerMode: DateTimePickerMode.datetime,
                  dateFormat: 'MMM dd yyyy HH mm',
                  onConfirm: (DateTime datetime, List<int> values) {
                    setState(() {
                      selectedDate = datetime;
                    });
                  },
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(selectedDate.toString()),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                label: Text('Location'),
              ),
            ),
            TextFormField(
              controller: _organizerController,
              decoration: const InputDecoration(
                label: Text('organizer'),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButton<EventType>(
              isExpanded: true,
              value: selectedEventType,
              hint: const Text('Event Type'),
              items: EventType.values
                  .where((e) => e != EventType.all)
                  .map(
                    (eventType) => DropdownMenuItem(
                      value: eventType,
                      child: Text(eventType.label),
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedEventType = newValue;
                });
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    eventsStore.selectedEvent == null ? _onSave : _onEdit,
                child: Text(
                  eventsStore.selectedEvent == null
                      ? 'Create Event'
                      : 'Update Event',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

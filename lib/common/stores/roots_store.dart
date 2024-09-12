// Package imports:
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// Project imports:

import 'events_store.dart';

class RootStore {
  late EventsStore eventsStore;

  RootStore() {
    eventsStore = EventsStore(this);
  }

  List<SingleChildWidget> get providers => [
        ChangeNotifierProvider<EventsStore>.value(
          value: eventsStore,
        ),
      ];

  void dispose() {
    eventsStore.dispose();
  }
}

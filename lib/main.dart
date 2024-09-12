import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:panda_frontend/common/stores/roots_store.dart';
import 'package:panda_frontend/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late RootStore _rootStore;

  @override
  void initState() {
    super.initState();
    _rootStore = RootStore();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _rootStore.providers,
      child: MaterialApp.router(
        routeInformationProvider: goRouter.routeInformationProvider,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        title: 'Panda Hub Test',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

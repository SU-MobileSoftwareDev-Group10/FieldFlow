import 'package:field_flow/homepage.dart';
import 'package:field_flow/nav_menu.dart';
import 'package:field_flow/providers/position_provider.dart';
import 'package:field_flow/providers/time_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'db/firestore_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => FirestoreHelper()),
      ChangeNotifierProvider(
        create: (context) => TimeTracker(
            firestoreHelper:
                Provider.of<FirestoreHelper>(context, listen: false)),
      ),
      ChangeNotifierProvider(
        create: (context) => PositionProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(autoStart: false),
      androidConfiguration: AndroidConfiguration(
          onStart: serviceOnStart,
          isForegroundMode: true,
          autoStart: false,
          autoStartOnBoot: false,
          foregroundServiceTypes: [AndroidForegroundType.location]));
}

Future<void> serviceOnStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  service.on("startTracking").listen((event) {
    PositionProvider().startTracking(() {
      debugPrint("Background Tracking Running");
    });
  });

  service.on("stopTracking").listen((event) {
    PositionProvider().stopTracking();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FieldFlow',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const NavMenu(parent: Homepage(checkInAgain: Duration(seconds: 5))),
    );
  }
}

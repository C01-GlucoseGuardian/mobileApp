import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/firebase_options.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/screens/landing.dart';
import 'package:glucose_guardian/screens/login.dart';
import 'package:glucose_guardian/screens/paziente_home.dart';
import 'package:glucose_guardian/screens/tutore_home.dart';
import 'package:glucose_guardian/services/db/hive_assunzione_farmaco_service.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  String title = message.data['title'] ?? "Nuova notifica!";
  String content = message.data['message'];

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'com.vitp.glucoseguardian',
    'Glucose Guardian',
    channelDescription: 'Notifica Glucose Guardian',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    ticker: 'ticker',
  );
  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
    ),
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    content,
    notificationDetails,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await SharedPreferenceService.init();
  await Hive.initFlutter();
  Hive.registerAdapter(AssunzioneFarmacoAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());

  await HiveAssunzioneFarmacoService.init("assunzioneFarmaco");

  initializeDateFormatting('it', null).then((_) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? home;

    switch (getFirstScreenState()) {
      case FirstScreenState.neverOpenedApp:
        home = const Landing();
        break;
      case FirstScreenState.openedAppButNotLogged:
        home = const Login();
        break;
      case FirstScreenState.loggedAsPaziente:
        home = const PazienteHome();
        break;
      case FirstScreenState.loggedAsTutore:
        home = const TutoreHome();
        break;
    }

    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(primaryColor: kOrangePrimary),
      home: home,
    );
  }
}

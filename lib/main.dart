import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/screens/landing.dart';
import 'package:glucose_guardian/screens/login.dart';
import 'package:glucose_guardian/screens/paziente_home.dart';
import 'package:glucose_guardian/screens/tutore_home.dart';
import 'package:glucose_guardian/services/db/hive_assunzione_farmaco_service.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

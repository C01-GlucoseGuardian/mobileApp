import 'package:flutter/material.dart';
import 'package:glucose_guardian/_mock_data.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/screens/paziente_home.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('it', null).then((_) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(primaryColor: kOrangePrimary),
      home: PazienteHome(
        user: kMockUser,
      ),
    );
  }
}

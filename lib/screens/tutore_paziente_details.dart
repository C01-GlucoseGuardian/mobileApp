import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/screens/paziente_agenda.dart';
import 'package:glucose_guardian/screens/paziente_doctor_screen.dart';
import 'package:glucose_guardian/screens/paziente_home.dart';
import 'package:glucose_guardian/screens/paziente_profilo.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class TutorePazienteDetails extends StatelessWidget {
  final Paziente paziente;

  const TutorePazienteDetails({super.key, required this.paziente});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: kBlue),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomNavigationBarIndex>(
            create: (_) => BottomNavigationBarIndex(0),
          ),
        ],
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: _createAppBar(context),
          bottomNavigationBar: Builder(
            builder: (context) => BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              enableFeedback: true,
              selectedFontSize: 0,
              currentIndex:
                  Provider.of<BottomNavigationBarIndex>(context).index,
              onTap: (newIndex) {
                int currentIndex = Provider.of<BottomNavigationBarIndex>(
                        context,
                        listen: false)
                    .index;
                if (currentIndex != newIndex) {
                  String nextRoute = kTutoreHomeNavigatorPaths[newIndex];
                  navigatorKey.currentState?.pushReplacementNamed(nextRoute);
                  Provider.of<BottomNavigationBarIndex>(context, listen: false)
                      .index = newIndex;
                } else {
                  // user re-clicks on the
                  // current bottomnavigationbar item
                }
              },
              items: [
                _createBottomNavigationBarItem(
                  context,
                  0,
                  'home',
                  FontAwesomeIcons.house,
                ),
                _createBottomNavigationBarItem(
                  context,
                  1,
                  'agenda',
                  FontAwesomeIcons.calendar,
                ),
                _createBottomNavigationBarItem(
                  context,
                  2,
                  'dottore',
                  FontAwesomeIcons.userDoctor,
                ),
                _createBottomNavigationBarItem(
                  context,
                  3,
                  'profilo',
                  FontAwesomeIcons.user,
                ),
              ],
            ),
          ),
          body: Navigator(
            key: navigatorKey,
            onGenerateRoute: (settings) {
              // local function, animations disabled
              PageRouteBuilder builder(Widget page) => PageRouteBuilder(
                    pageBuilder: (_, __, ___) => page,
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  );

              switch (settings.name) {
                case 'agenda':
                  return builder(
                    PazienteAgenda(
                      codiceFiscalePaziente: paziente.codiceFiscale,
                    ),
                  );
                case 'dottore':
                  return builder(
                    PazienteDoctorScreen(
                      codiceFiscalePaziente: paziente.codiceFiscale,
                    ),
                  );
                case 'profilo':
                  return builder(
                    PazienteProfilo(
                      codiceFiscalePaziente: paziente.codiceFiscale,
                    ),
                  );
                case 'home':
                default:
                  return builder(
                    PazienteHomeDashboard(
                      codiceFiscalePaziente: paziente.codiceFiscale,
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(
      BuildContext context, int index, String label, IconData icon) {
    int currentIndex = Provider.of<BottomNavigationBarIndex>(context).index;
    return BottomNavigationBarItem(
      icon: CircleAvatar(
        backgroundColor:
            currentIndex == index ? kBackgroundColor : Colors.transparent,
        foregroundColor: currentIndex == index
            ? Theme.of(context).primaryColor
            : Colors.black,
        child: Padding(
          padding: currentIndex == index
              ? const EdgeInsets.all(8.0)
              : EdgeInsets.zero,
          child: Icon(
            icon,
            size: 18,
          ),
        ),
      ),
      label: label,
    );
  }

  AppBar _createAppBar(BuildContext context) => AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Dettagli paziente ${paziente.nome}"),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
      );
}

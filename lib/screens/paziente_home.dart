import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucose_guardian/components/day_selector.dart';
import 'package:glucose_guardian/components/empty_data.dart';
import 'package:glucose_guardian/components/glucose_chart.dart';
import 'package:glucose_guardian/constants/assets.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/models/farmaco.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/screens/cgm_connect.dart';
import 'package:glucose_guardian/screens/paziente_agenda.dart';
import 'package:glucose_guardian/screens/paziente_doctor_screen.dart';
import 'package:glucose_guardian/screens/paziente_notifiche.dart';
import 'package:glucose_guardian/screens/paziente_profilo.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

final Paziente paziente = Paziente(); // TODO: only here because I hate errors
final Dottore dottore = Dottore();
final Farmaco farmaco = Farmaco();
final List<AssunzioneFarmaco> farmaci = List.empty();
final List<Notifica> notifiche = List.empty();
final List<Glicemia> misurazioni = List.empty();

class PazienteHome extends StatelessWidget {
  const PazienteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
            currentIndex: Provider.of<BottomNavigationBarIndex>(context).index,
            onTap: (newIndex) {
              int currentIndex =
                  Provider.of<BottomNavigationBarIndex>(context, listen: false)
                      .index;
              if (currentIndex != newIndex) {
                String nextRoute = kHomeNavigatorPaths[newIndex];
                homeNavigatorKey.currentState?.pushReplacementNamed(nextRoute);
                Provider.of<BottomNavigationBarIndex>(context, listen: false)
                    .index = newIndex;
              } else {
                // TODO: handle what should happen if the user re-clicks on the
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
                'notifiche',
                FontAwesomeIcons.bell,
              ),
              _createBottomNavigationBarItem(
                context,
                3,
                'dottore',
                FontAwesomeIcons.userDoctor,
              ),
              _createBottomNavigationBarItem(
                context,
                4,
                'profilo',
                FontAwesomeIcons.user,
              ),
            ],
          ),
        ),
        body: Navigator(
          key: homeNavigatorKey,
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
                    drugs: farmaci,
                  ),
                );
              case 'notifiche':
                return builder(PazienteNotifiche(
                  notifications: notifiche,
                ));
              case 'dottore':
                return builder(
                  PazienteDoctorScreen(
                    doctor: dottore,
                  ),
                );
              case 'profilo':
                return builder(
                  const PazienteProfilo(),
                );
              case 'home':
              default:
                return builder(
                  const _PazienteHomeDashboard(),
                );
            }
          },
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
        title: Text("Ciao, ${paziente.nome}!"),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (_) => CGMConnect(),
                ),
              );
            },
            icon: SvgPicture.asset(
              kCgmIcon,
              color: Colors.black,
              width: 28,
              height: 28,
            ),
          ),
        ],
      );
}

class _PazienteHomeDashboard extends StatelessWidget {
  const _PazienteHomeDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        if (misurazioni.isNotEmpty) ...[
          const DaySelector(),
          GlucoseCard(
            measurementsOfSelectedDay: misurazioni,
          ),
          GlucoseChartCard(
            measurementsOfSelectedDay: misurazioni,
          ),
        ],
        if (misurazioni.isEmpty)
          const EmptyData(text: "Non ci sono misurazioni recenti!"),
      ],
    );
  }
}

class GlucoseCard extends StatefulWidget {
  final List<Glicemia> measurementsOfSelectedDay;
  const GlucoseCard({super.key, required this.measurementsOfSelectedDay});

  @override
  State<GlucoseCard> createState() => _GlucoseCardState();
}

class _GlucoseCardState extends State<GlucoseCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // assuming they're already sorted by date, last is least measurement
    Glicemia last = widget.measurementsOfSelectedDay.last;
    Glicemia lowest = getLowest(widget.measurementsOfSelectedDay);
    Glicemia highest = getHighest(widget.measurementsOfSelectedDay);
    Glicemia mean = Glicemia(); // TODO:

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      height: isExpanded ? 200 : 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: InkWell(
        onTap: () => setState(() => isExpanded = !isExpanded),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: kBackgroundColor,
                    foregroundColor: kOrangePrimary,
                    child: Icon(
                      Icons.bloodtype_rounded,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Glucosio: ${last.livelloGlucosio!} ${kGlucoseUOM}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        isGlucoseValueNormal(last.livelloGlucosio!)
                            ? "Ti dovresti sentire bene!"
                            : "Fai attenzione al livello di glucosio!",
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                  )
                ],
              ),
            ),
            if (isExpanded)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMaxMinNormalWidget(
                        highest, Icons.arrow_upward_rounded, "Alto"),
                    _buildMaxMinNormalWidget(
                        mean, Icons.check_circle_sharp, "Medio"),
                    _buildMaxMinNormalWidget(
                        lowest, Icons.arrow_downward_rounded, "Basso"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Row _buildMaxMinNormalWidget(Glicemia higher, IconData icon, String desc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).primaryColor,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: higher.livelloGlucosio!.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: " $kGlucoseUOM",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

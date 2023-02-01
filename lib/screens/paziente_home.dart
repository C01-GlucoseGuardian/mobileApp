import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glucose_guardian/_mock_data.dart';
import 'package:glucose_guardian/components/day_selector.dart';
import 'package:glucose_guardian/components/glucose_chart.dart';
import 'package:glucose_guardian/constants/assets.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/screens/paziente_agenda.dart';
import 'package:glucose_guardian/screens/paziente_notifiche.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

class PazienteHome extends StatelessWidget {
  final Paziente user;

  const PazienteHome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarIndex>(
      create: (_) => BottomNavigationBarIndex(0),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: _createAppBar(),
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
                Icons.home_rounded,
              ),
              _createBottomNavigationBarItem(
                context,
                1,
                'agenda',
                Icons.calendar_month_rounded,
              ),
              _createBottomNavigationBarItem(
                context,
                2,
                'notifiche',
                Icons.notifications_none_rounded,
              ),
              _createBottomNavigationBarItem(
                context,
                3,
                'dottore',
                Icons.medical_information_rounded, // TODO: icon
              ),
              _createBottomNavigationBarItem(
                context,
                4,
                'profilo',
                Icons.person_2_rounded,
              ),
            ],
          ),
        ),
        body: Navigator(
          key: homeNavigatorKey,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case 'agenda':
                return MaterialPageRoute(
                  builder: (_) => PazienteAgenda(drugs: kMockFarmaci),
                );
              case 'notifiche':
                return MaterialPageRoute(
                  builder: (_) => PazienteNotifiche(
                    notifications: kMockNotifiche,
                  ),
                );
              case 'dottore':
                return MaterialPageRoute(
                  builder: (_) => const Text("Dottore"),
                );
              case 'profilo':
                return MaterialPageRoute(
                  builder: (_) => const Text("Profilo"),
                );
              case 'home':
              default:
                return MaterialPageRoute(
                  builder: (_) => const _PazienteHomeDashboard(),
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
          child: Icon(icon),
        ),
      ),
      label: label,
    );
  }

  AppBar _createAppBar() => AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Text("Ciao, ${user.nome}!"),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {}, // TODO: bring user to CGM Selector page
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
        const DaySelector(),
        GlucoseCard(
          measurementsOfSelectedDay: kMockMeasurements,
        ),
        GlucoseChartCard(
          measurementsOfSelectedDay: kMockMeasurements,
        ),
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

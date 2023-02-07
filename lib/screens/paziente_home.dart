import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/bloc/measurements/measurements_bloc.dart';
import 'package:glucose_guardian/components/day_selector.dart';
import 'package:glucose_guardian/components/empty_data.dart';
import 'package:glucose_guardian/components/error_screen.dart';
import 'package:glucose_guardian/components/glucose_chart.dart';
import 'package:glucose_guardian/components/loading.dart';
import 'package:glucose_guardian/constants/assets.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/dates.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/screens/cgm_connect.dart';
import 'package:glucose_guardian/screens/paziente_agenda.dart';
import 'package:glucose_guardian/screens/paziente_doctor_screen.dart';
import 'package:glucose_guardian/screens/paziente_notifiche.dart';
import 'package:glucose_guardian/screens/paziente_profilo.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

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
      child: Banner(
        location: BannerLocation.topEnd,
        message: "HACKER",
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
                  String nextRoute = kHomeNavigatorPaths[newIndex];
                  homeNavigatorKey.currentState
                      ?.pushReplacementNamed(nextRoute);
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
                    const PazienteAgenda(),
                  );
                case 'notifiche':
                  return builder(
                    const PazienteNotifiche(),
                  );
                case 'dottore':
                  return builder(
                    const PazienteDoctorScreen(),
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
        title: FutureBuilder(
            future:
                api.fetchLoggedPaziente(SharedPreferenceService.codiceFiscale!),
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data!.nome != null) {
                return Text("Ciao, ${snapshot.data!.nome!}!");
              }
              return const Text("Ciao!");
            }),
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

class _PazienteHomeDashboard extends StatefulWidget {
  const _PazienteHomeDashboard({
    super.key,
  });

  @override
  State<_PazienteHomeDashboard> createState() => _PazienteHomeDashboardState();
}

class _PazienteHomeDashboardState extends State<_PazienteHomeDashboard> {
  final MeasurementsBloc _bloc = MeasurementsBloc();

  @override
  void initState() {
    _bloc.add(
      GetMeasurementsInRange(
        lastMidnight.millisecondsSinceEpoch,
        now.millisecondsSinceEpoch,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: _buildContent(),
    );
  }

  ListView _buildContent() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        DaySelector(
          callback: (day) {
            List<DateTime> span = getDayTimeSpan(day);
            _bloc.add(GetMeasurementsInRange(span[0].millisecondsSinceEpoch,
                span[1].millisecondsSinceEpoch));
          },
        ),
        BlocBuilder<MeasurementsBloc, MeasurementsState>(
          builder: (context, state) {
            if (state is MeasurementsInitial || state is MeasurementsLoading) {
              return const Loading(
                child: CircleAvatar(
                  backgroundColor: kBackgroundColor,
                  child: Icon(
                    Icons.bloodtype_rounded,
                    size: 20,
                    color: kOrangePrimary,
                  ),
                ),
              );
            } else if (state is MeasurementsLoaded) {
              List<Glicemia> measurements = state.measurements;
              if (measurements.isEmpty) {
                return const EmptyData(
                  text: "Non ci sono misurazioni nel range selezionato",
                );
              }
              return GlucoseCard(
                measurementsOfSelectedDay: measurements,
              );
            } else {
              return const ErrorScreen(text: "Errore"); // TODO:
            }
          },
        ),
        BlocBuilder<MeasurementsBloc, MeasurementsState>(
          builder: (context, state) {
            if (state is MeasurementsInitial || state is MeasurementsLoading) {
              return Container(); // only one loading
            } else if (state is MeasurementsLoaded) {
              List<Glicemia> measurements = state.measurements;
              if (measurements.isEmpty) {
                return Container();
              }

              return GlucoseChartCard(
                measurementsOfSelectedDay: measurements,
              );
            } else {
              return const ErrorScreen(text: "Errore"); // TODO:
            }
          },
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
    int mean = (widget.measurementsOfSelectedDay.fold(
                0,
                (previousValue, element) =>
                    previousValue + element.livelloGlucosio!) /
            widget.measurementsOfSelectedDay.length)
        .floor();

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
                        null, Icons.check_circle_sharp, "Medio",
                        value: mean),
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

  Row _buildMaxMinNormalWidget(Glicemia? higher, IconData icon, String desc,
      {int? value}) {
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
                    text: higher != null
                        ? higher.livelloGlucosio!.toString()
                        : value!.toString(),
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

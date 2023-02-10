import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:glucose_guardian/models/tutore.dart';
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
                    const PazienteHomeDashboard(),
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
                  builder: (_) => const CGMConnect(),
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

class PazienteHomeDashboard extends StatefulWidget {
  final String? codiceFiscalePaziente;
  const PazienteHomeDashboard({super.key, this.codiceFiscalePaziente});

  @override
  State<PazienteHomeDashboard> createState() => _PazienteHomeDashboardState();
}

class _PazienteHomeDashboardState extends State<PazienteHomeDashboard> {
  MeasurementsBloc _bloc = MeasurementsBloc();
  late Timer dataGenTimer;
  DateTime currentDay = DateTime.now();

  @override
  void initState() {
    _bloc.add(
      GetMeasurementsInRange(
        lastMidnight.millisecondsSinceEpoch,
        now.millisecondsSinceEpoch,
        codiceFiscalePaziente: widget.codiceFiscalePaziente,
      ),
    );

    if (widget.codiceFiscalePaziente == null) {
      // start data generator
      dataGenTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
        Glicemia glicemia = Glicemia(
          livelloGlucosio: Random().nextInt(100) + 60, // 60 <= x < 160
          timestamp: DateTime.now().millisecondsSinceEpoch,
        );
        // update UI only if selected date is today
        if (isToday(currentDay)) {
          if (_bloc.isClosed) {
            _bloc = MeasurementsBloc();
          }
          _bloc.add(AddGlicemia(glicemia));
        }
      });
    }
    super.initState();
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.day == date.day &&
        now.month == date.month &&
        now.year == date.year;
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
            setState(() {
              currentDay = day;
            });
            List<DateTime> span = getDayTimeSpan(day);
            _bloc.add(
              GetMeasurementsInRange(
                span[0].millisecondsSinceEpoch,
                span[1].millisecondsSinceEpoch,
              ),
            );
          },
        ),
        if (isToday(currentDay))
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: kBackgroundColor,
                  foregroundColor: kOrangePrimary,
                ),
                onPressed: () {
                  final TextEditingController notificationTextController =
                      TextEditingController();
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    body: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Inserisci testo notifica",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: notificationTextController,
                            maxLines: 4,
                            maxLength: 1024,
                            decoration: InputDecoration(
                              hintText: "Testo notifica",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              if (notificationTextController.text.isEmpty) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  title:
                                      "Il testo della notifica non può essere vuoto",
                                ).show();
                              } else {
                                bool isTutore =
                                    widget.codiceFiscalePaziente != null;
                                final Dottore dottore =
                                    await api.fetchDottoreByPazienteCF(
                                  isTutore
                                      ? widget.codiceFiscalePaziente!
                                      : SharedPreferenceService.codiceFiscale!,
                                );

                                if (isTutore) {
                                  Notifica notifica = Notifica(
                                    pazienteDestinatario:
                                        widget.codiceFiscalePaziente,
                                    messaggio: notificationTextController.text,
                                    pazienteOggetto:
                                        widget.codiceFiscalePaziente,
                                    dottoreDestinatario: dottore.codiceFiscale,
                                    tutoreDestinatario:
                                        SharedPreferenceService.codiceFiscale,
                                  );

                                  api.sendNotifica(notifica).then(
                                      (value) => Navigator.of(context).pop());
                                } else {
                                  api
                                      .fetchTutoreByPazienteCF(
                                          SharedPreferenceService
                                              .codiceFiscale!)
                                      .then(
                                        (List<Tutore> tutori) => tutori.forEach(
                                          (tutore) {
                                            Notifica notifica = Notifica(
                                              pazienteDestinatario:
                                                  SharedPreferenceService
                                                      .codiceFiscale,
                                              messaggio:
                                                  notificationTextController
                                                      .text,
                                              pazienteOggetto:
                                                  SharedPreferenceService
                                                      .codiceFiscale,
                                              dottoreDestinatario:
                                                  dottore.codiceFiscale,
                                              tutoreDestinatario:
                                                  tutore.codiceFiscale,
                                            );

                                            api.sendNotifica(notifica).then(
                                                (value) => Navigator.of(context)
                                                    .pop());
                                          },
                                        ),
                                      );
                                }
                              }
                            },
                            icon: const Icon(Icons.send),
                            label: const Text("INVIA"),
                          )
                        ],
                      ),
                    ),
                  ).show();
                },
                label: Text(
                    "Invia notifica ${widget.codiceFiscalePaziente == null ? 'a tutore e dottore' : ''}"),
                icon: const Icon(
                  Icons.send_rounded,
                  color: kOrangePrimary,
                ),
              ),
            ),
          ),
        BlocBuilder<MeasurementsBloc, MeasurementsState>(
          builder: (context, state) {
            if (state is MeasurementsInitial || state is MeasurementsLoading) {
              return Loading(
                child: CircleAvatar(
                  backgroundColor: kBackgroundColor,
                  child: Icon(
                    Icons.bloodtype_rounded,
                    size: 20,
                    color: Theme.of(context).primaryColor,
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
              return ErrorScreen(
                text:
                    "Errore.\nMessaggio: ${state is MeasurementsError ? state.error : 'NON PRESENTE'}",
              );
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
              return ErrorScreen(
                text:
                    "Errore.\nMessaggio: ${state is MeasurementsError ? state.error : 'NON PRESENTE'}",
              );
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
                  CircleAvatar(
                    backgroundColor: kBackgroundColor,
                    foregroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
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
                        "Glucosio: ${last.livelloGlucosio!} $kGlucoseUOM",
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

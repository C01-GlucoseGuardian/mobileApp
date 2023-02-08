import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/bloc/tutore/tutore_bloc.dart';
import 'package:glucose_guardian/components/empty_data.dart';
import 'package:glucose_guardian/components/error_screen.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/models/numero_utile.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/screens/change_password.dart';
import 'package:glucose_guardian/screens/login.dart';
import 'package:glucose_guardian/screens/paziente_notifiche.dart';
import 'package:glucose_guardian/screens/tutore_paziente_details.dart';

import '../components/loading.dart';
import '../services/shared_preferences_service.dart';

class TutoreHome extends StatefulWidget {
  const TutoreHome({super.key});

  @override
  State<TutoreHome> createState() => _TutoreHomeState();
}

class _TutoreHomeState extends State<TutoreHome> {
  final TutoreBloc _bloc = TutoreBloc();
  final sizedBox = const SizedBox(
    height: 8,
  );

  @override
  void initState() {
    _bloc.add(GetTutore());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: kBlue),
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: _createAppBar(context),
            body: BlocProvider(
              create: (context) => _bloc,
              child: BlocBuilder<TutoreBloc, TutoreState>(
                builder: (context, state) {
                  if (state is TutoreLoading || state is TutoreInitial) {
                    return Loading(
                      child: CircleAvatar(
                        backgroundColor: kBackgroundColor,
                        child: Icon(
                          FontAwesomeIcons.userDoctor,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  } else if (state is TutoreLoaded) {
                    if (state.tutore.pazienteList == null ||
                        state.tutore.pazienteList!.isEmpty) {
                      return const EmptyData(
                          text:
                              "Non ci sono pazienti collegati a questo tutore");
                    }
                    return ListView.builder(
                      itemCount: state.tutore.pazienteList?.length ?? 0,
                      itemBuilder: (context, index) => _buildPatientCard(
                          context, state.tutore.pazienteList![index]),
                    );
                  } else {
                    return ErrorScreen(
                      text:
                          "Errore.\nMessaggio: ${state is TutoreError ? state.error : 'NON PRESENTE'}",
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPatientCard(BuildContext context, Paziente paziente) => InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TutorePazienteDetails(
              paziente: paziente,
            ),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: CircleAvatar(
                  backgroundColor: kBackgroundColor,
                  child: Icon(
                    FontAwesomeIcons.user,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildField(
                      "nome",
                      paziente.nome!,
                    ),
                    sizedBox,
                    _buildField(
                      "cognome",
                      paziente.cognome!,
                    ),
                    sizedBox,
                    _buildField(
                      "codice fiscale",
                      paziente.codiceFiscale!,
                    ),
                    sizedBox,
                    if (paziente.numeriUtili != null)
                      Column(
                        children: [
                          for (NumeroUtile n in paziente.numeriUtili!)
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  n.numero!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildField(String desc, String content) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          desc.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          content,
          style: const TextStyle(
            fontSize: 18,
          ),
        )
      ],
    );
  }

  AppBar _createAppBar(BuildContext context) => AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: FutureBuilder(
            future:
                api.fetchLoggedTutore(SharedPreferenceService.codiceFiscale!),
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
                  builder: (_) => const NotificheTutore(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (_) => ChangePassword(
                    tutore: true,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.key_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              SharedPreferenceService.logout();
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const Login(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      );
}

class NotificheTutore extends StatelessWidget {
  const NotificheTutore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Notifiche"),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          foregroundColor: Colors.black,
        ),
        body: const PazienteNotifiche(),
      ),
    );
  }
}

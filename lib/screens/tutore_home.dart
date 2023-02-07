import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/bloc/tutore/tutore_bloc.dart';
import 'package:glucose_guardian/components/error_screen.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/models/numero_utile.dart';

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
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: _createAppBar(context),
        body: BlocProvider(
          create: (context) => _bloc,
          child: BlocBuilder<TutoreBloc, TutoreState>(
            builder: (context, state) {
              if (state is TutoreLoading || state is TutoreInitial) {
                return const Loading(
                  child: CircleAvatar(
                    backgroundColor: kBackgroundColor,
                    child: Icon(
                      FontAwesomeIcons.userDoctor,
                      size: 20,
                      color: kOrangePrimary,
                    ),
                  ),
                );
              } else if (state is TutoreLoaded) {
                return ListView.builder(
                  itemCount: state.tutore.pazienteList?.length ?? 0,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 4,
                          child: CircleAvatar(
                            backgroundColor: kBackgroundColor,
                            child: Icon(
                              FontAwesomeIcons.user,
                              size: 20,
                              color: kOrangePrimary,
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
                                state.tutore.pazienteList![index].nome!,
                              ),
                              sizedBox,
                              _buildField(
                                "cognome",
                                state.tutore.pazienteList![index].cognome!,
                              ),
                              sizedBox,
                              _buildField(
                                "codice fiscale",
                                state
                                    .tutore.pazienteList![index].codiceFiscale!,
                              ),
                              sizedBox,
                              if (state.tutore.pazienteList![index]
                                      .numeriUtili !=
                                  null)
                                Column(
                                  children: [
                                    for (NumeroUtile n in state.tutore
                                        .pazienteList![index].numeriUtili!)
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            color: kOrangePrimary,
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
              } else {
                return ErrorScreen(
                  text:
                      "Errore.\nMessaggio: ${state is TutoreError ? state.error : 'NON PRESENTE'}",
                );
              }
            },
          ),
        ),
      ),
    );
  }

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
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
          )
        ],
      );
}

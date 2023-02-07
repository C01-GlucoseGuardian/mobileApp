import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucose_guardian/bloc/patient/patient_bloc.dart';
import 'package:glucose_guardian/components/error_screen.dart';
import 'package:glucose_guardian/components/loading.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/screens/login.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';
import 'package:intl/intl.dart';

class PazienteProfilo extends StatefulWidget {
  final String? codiceFiscalePaziente;

  const PazienteProfilo({super.key, this.codiceFiscalePaziente});

  @override
  State<PazienteProfilo> createState() => _PazienteProfiloState();
}

class _PazienteProfiloState extends State<PazienteProfilo> {
  final PatientBloc _bloc = PatientBloc();
  final sizedBox = const SizedBox(
    height: 8,
  );

  @override
  void initState() {
    _bloc.add(GetPatient(codiceFiscalePaziente: widget.codiceFiscalePaziente));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Informazioni paziente",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => _bloc,
          child: BlocBuilder<PatientBloc, PatientState>(
            builder: (context, state) {
              if (state is PatientInitial || state is PatientLoading) {
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
              } else if (state is PatientLoaded) {
                Paziente paziente = state.patient;

                return _buildContent(context, paziente);
              } else {
                return ErrorScreen(
                  text:
                      "Errore.\nMessaggio: ${state is PatientError ? state.error : 'NON PRESENTE'}",
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Container _buildContent(BuildContext context, Paziente user) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundColor: kBackgroundColor,
              child: Icon(
                FontAwesomeIcons.userDoctor,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildField(
                  "nome",
                  user.nome ?? "NON PRESENTE",
                ),
                sizedBox,
                _buildField(
                  "cognome",
                  user.cognome ?? "NON PRESENTE",
                ),
                sizedBox,
                _buildField(
                  "codice fiscale",
                  user.codiceFiscale ?? "NON PRESENTE",
                ),
                sizedBox,
                _buildField(
                  "data di nascita",
                  user.dataNascita != null
                      ? DateFormat("dd/MM/yyyy").format(user.dataNascita!)
                      : "NON PRESENTE",
                ),
                sizedBox,
                _buildField(
                  "indirizzo",
                  user.indirizzo ?? "NON PRESENTE",
                ),
                sizedBox,
                _buildField(
                  "telefono",
                  user.telefono ?? "NON PRESENTE",
                ),
                sizedBox,
                _buildField(
                  "email",
                  user.email ?? "NON PRESENTE",
                ),
                _buildField(
                  "Tipo diabete",
                  user.tipoDiabete ?? "NON PRESENTE",
                ),
                _buildField(
                  "Comorbilità",
                  user.comorbilita ?? "NON PRESENTE",
                ),
                _buildField(
                  "Farmaci assunti",
                  user.farmaciAssunti ?? "NON PRESENTE",
                ),
                if (widget.codiceFiscalePaziente == null)
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: kBackgroundColor,
                      foregroundColor: kOrangePrimary,
                    ),
                    onPressed: () {
                      SharedPreferenceService.logout();
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const Login(),
                        ),
                      );
                    },
                    label: const Text("Log out"),
                    icon: const Icon(
                      Icons.logout,
                      color: kOrangePrimary,
                    ),
                  )
              ],
            ),
          ),
        ],
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
}

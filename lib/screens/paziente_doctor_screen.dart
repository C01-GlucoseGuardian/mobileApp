import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/screens/paziente_send_feedback.dart';
import 'package:intl/intl.dart';

class PazienteDoctorScreen extends StatelessWidget {
  final Dottore doctor;

  const PazienteDoctorScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 8,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Informazioni dottore",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Container(
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
              const Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor: kBackgroundColor,
                  child: Icon(
                    FontAwesomeIcons.userDoctor,
                    size: 20,
                    color: kOrangePrimary,
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
                      doctor.nome ?? "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "cognome",
                      doctor.cognome ?? "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "codice fiscale",
                      doctor.codiceFiscale ?? "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "data di nascita",
                      doctor.dataNascita != null
                          ? DateFormat("dd/MM/yyyy").format(doctor.dataNascita!)
                          : "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "indirizzo",
                      doctor.indirizzo ?? "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "telefono",
                      doctor.telefono ?? "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "email",
                      doctor.email ?? "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "specializzazione",
                      doctor.specializzazione ?? "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "nome struttura medica",
                      doctor.nomeStruttura ?? "NON PRESENTE",
                    ),
                    sizedBox,
                    _buildField(
                      "indirizzo struttura medica",
                      doctor.indirizzoStruttura ?? "NON PRESENTE",
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: SendFeedbackButton(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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

class SendFeedbackButton extends StatelessWidget {
  const SendFeedbackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: kBackgroundColor,
        foregroundColor: kOrangePrimary,
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => const PazienteSendFeedback(),
          ),
        );
      },
      label: const Text("Invia feedback terapia"),
      icon: const Icon(
        Icons.send_rounded,
        color: kOrangePrimary,
      ),
    );
  }
}

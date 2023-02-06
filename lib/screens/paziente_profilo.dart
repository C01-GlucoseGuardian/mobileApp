import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:intl/intl.dart';

class PazienteProfilo extends StatelessWidget {
  final Paziente user;

  const PazienteProfilo({super.key, required this.user});

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

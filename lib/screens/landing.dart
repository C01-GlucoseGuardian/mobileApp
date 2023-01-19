import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/assets.dart';
import 'package:glucose_guardian/constants/strings.dart';

/// Landing screen
///
/// This will be called once when opening the app for the first time
/// Store maybe in the shared preferences a boolean indicating if the app
/// has previously been opened or not
class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Image.asset(
                kLogoTransparent,
                semanticLabel: "Logo dell'applicazione",
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Cos'è Glucose Guardian?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                  ),
                  const Center(
                    child: Text(
                      kAppDescription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Semantics(
                        button: true,
                        hint: "Bottone per proseguire alla prossima schermata",
                        child: MaterialButton(
                          onPressed:
                              () {}, // TODO: it should close this screen and go to the next one (login)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: const Text("Avanti"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

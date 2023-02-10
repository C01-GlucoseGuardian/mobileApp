import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:passwordfield/passwordfield.dart';

class ChangePassword extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final bool tutore;
  ChangePassword({super.key, this.tutore = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(primaryColor: tutore ? kBlue : kOrangePrimary),
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: kBackgroundColor,
          elevation: 0,
          centerTitle: false,
          title: const Text("Cambio password"),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          foregroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: PasswordField(
                hintText: "Password corrente",
                passwordConstraint: r'[0-9a-zA-Z]{4,}',
                controller: passwordController,
                border: PasswordBorder(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: PasswordField(
                hintText: "Nuova password",
                passwordConstraint: r'[0-9a-zA-Z]{4,}',
                controller: newPasswordController,
                border: PasswordBorder(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: PasswordField(
                hintText: "Conferma nuova password",
                passwordConstraint: r'[0-9a-zA-Z]{4,}',
                controller: confirmPasswordController,
                border: PasswordBorder(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size.fromHeight(
                    40,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: tutore ? kBlue : kOrangePrimary,
                ),
                onPressed: () async {
                  Loader.show(context);
                  if (passwordController.text.isEmpty ||
                      newPasswordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    Loader.hide();
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      title: "Completa i 3 campi per proseguire",
                    ).show();
                  } else {
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      Loader.hide();

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        title:
                            "La nuova password e la conferma della nuova password devono combaciare, ricontrolla",
                      ).show();
                    } else {
                      try {
                        var resp = await api.changePassword(
                            passwordController.text,
                            newPasswordController.text);
                        if (resp) {
                          Loader.hide();

                          // ignore: use_build_context_synchronously
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            title: "Password cambiata con successo",
                          ).show().then((value) => Navigator.of(context).pop());
                        } else {
                          throw Exception();
                        }
                      } catch (_) {
                        Loader.hide();

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          title:
                              "Si è verificato un problema durante il cambio di password, controlla che la tua vecchia password sia corretta e riprova.",
                        ).show();
                      }
                    }
                  }
                },
                child: const Text("Cambia password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/strings.dart';
import 'package:glucose_guardian/models/feedback.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

class PazienteSendFeedback extends StatelessWidget {
  final TextEditingController fController = TextEditingController();
  final TextEditingController sController = TextEditingController();
  final TextEditingController tController = TextEditingController();
  final TextEditingController qController = TextEditingController();

  PazienteSendFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 8,
    );

    return MaterialApp(
      home: GestureDetector(
        // remove focus on textfields when clicking outside
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
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
            title: const Text("Invia sintomi al dottore"),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            foregroundColor: Colors.black,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: fController,
                maxLength: 300,
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  label: Text(
                    kFeedbackSendStrings[0],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              sizedBox,
              TextFormField(
                controller: sController,
                maxLength: 300,
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  label: Text(
                    kFeedbackSendStrings[1],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              sizedBox,
              TextFormField(
                controller: tController,
                maxLength: 300,
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  label: Text(
                    kFeedbackSendStrings[2],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              sizedBox,
              TextFormField(
                controller: qController,
                maxLength: 300,
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  label: Text(
                    kFeedbackSendStrings[3],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              sizedBox,
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: kOrangePrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32))),
                onPressed: () async {
                  if (fController.text.trim().isEmpty ||
                      sController.text.trim().isEmpty ||
                      tController.text.trim().isEmpty ||
                      qController.text.trim().isEmpty) {
                    AwesomeDialog(
                      dialogType: DialogType.info,
                      context: context,
                      title: "Completa tutti i campi",
                    ).show();
                  } else {
                    try {
                      await api.sendFeedback(
                        FeedbackInput(
                          SharedPreferenceService.codiceFiscale!,
                          fController.text,
                          sController.text,
                          tController.text,
                          qController.text,
                        ),
                      );

                      // ignore: use_build_context_synchronously
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        title: "Inviato",
                      ).show().then(
                            (value) => Navigator.of(context).pop(),
                          );
                    } catch (e) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        title: "Errore nell'invio feedback",
                      ).show();
                    }
                  }
                },
                child: const Text("INVIA"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

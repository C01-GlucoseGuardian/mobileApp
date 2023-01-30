import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/strings.dart';

class PazienteSendFeedback extends StatelessWidget {
  const PazienteSendFeedback({super.key});

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
              TextField(
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
              TextField(
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
              TextField(
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
              TextField(
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
                onPressed: () {},
                child: const Text("INVIA"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

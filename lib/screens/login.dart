import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:glucose_guardian/constants/api.dart';
import 'package:glucose_guardian/constants/assets.dart';
import 'package:glucose_guardian/screens/paziente_home.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';
import 'package:passwordfield/passwordfield.dart';

/// Login screen
///
/// Screen with two (three after first login) fields where user will type
/// email and password, and next, if needed, it will be prompted to type
/// the OTP code.
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

// TODO: better accessibility https://www.a11yproject.com/
class _LoginState extends State<Login> {
  /// set this to true after first login API call
  bool? showOTPCodeInput;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Logo(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == " ") {
                          return null;
                        }
                        return EmailValidator.validate(value)
                            ? null
                            : "Email non valida";
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: showOTPCodeInput ?? false
                          ? 0
                          : 16, // adds padding only if otp field is not shown
                    ),
                    child: PasswordField(
                      controller: passwordController,
                      border: PasswordBorder(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  if (showOTPCodeInput ?? false)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: OtpTextField(
                        clearText: true,
                        onSubmit: (value) {
                          // ready to check if otp is valid
                        },
                      ),
                    ),
                  Semantics(
                    button: true,
                    hint: "Bottone per proseguire nel processo di login",
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size.fromHeight(
                          40,
                        ),
                      ),
                      onPressed: () {
                        // TODO: add login logic
                        SharedPreferenceService.bearerToken = "testtest";
                        SharedPreferenceService.userType = UserType.paziente;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const PazienteHome(),
                          ),
                        );
                      },
                      child: const Text(
                        "LOGIN",
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

class Logo extends StatefulWidget {
  const Logo({
    super.key,
  });

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  int clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            clicks++;
          });

          if (clicks >= 14 && clicks < 17) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Sei a ${17 - clicks} passi dal diventare Andrea Mennillo",
                ),
                duration: const Duration(milliseconds: 100),
              ),
            );
          }
          if (clicks == 17) {
            setState(() {
              clicks = 0;
            });
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ControlRoom(),
              ),
            );
          }
        },
        child: Center(
          child: SharedPreferenceService.customApiUrl.isNotEmpty
              ? ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.green,
                    BlendMode.modulate,
                  ),
                  child: _getChild(),
                )
              : _getChild(),
        ),
      ),
    );
  }

  Image _getChild() {
    return Image.asset(
      kLogoTransparent,
      semanticLabel: "Logo dell'applicazione",
    );
  }
}

class ControlRoom extends StatefulWidget {
  ControlRoom({
    super.key,
  });

  @override
  State<ControlRoom> createState() => _ControlRoomState();
}

class _ControlRoomState extends State<ControlRoom> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = SharedPreferenceService.customApiUrl.isNotEmpty
        ? SharedPreferenceService.customApiUrl
        : kApiUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            "https://media2.giphy.com/media/3o6gb3NDIb4lpesGWI/giphy.gif",
          ),
          const SizedBox(
            height: 40,
          ),
          Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Seal_of_the_U.S._National_Security_Agency.svg/1200px-Seal_of_the_U.S._National_Security_Agency.svg.png",
                ),
              ),
              Column(
                children: [
                  const Text(
                    "CAIVANO CONTROL ROOM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        focusColor: Colors.green,
                        hoverColor: Colors.green,
                        fillColor: Colors.green,
                        focusedBorder: OutlineInputBorder(),
                        label: Text("indirizzo, senza / finale"),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      print(SharedPreferenceService.customApiUrl);
                      print(controller.text);
                      SharedPreferenceService.customApiUrl = controller.text;
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "failed to connect to NSA Agent: Andrea Mennillo successfully",
                          ),
                        ),
                      );
                      print(SharedPreferenceService.customApiUrl);
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: const Text("SAVE THE MATRIX"),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

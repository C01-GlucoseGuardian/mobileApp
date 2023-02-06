import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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

import 'package:glucose_guardian/constants/general.dart';

/// 3 for prod server, 2 for staging, 1 (or everything else for development/debug)
const String kApiUrl = kAppStatus == 3
    ? "prod"
    : kAppStatus == 2
        ? "https://api.glucoseguardian.it"
        : "http://127.0.0.1:3000";

enum ApiEndPoints {
  login("/auth/login"),
  loginOtp("/auth/loginOtp"),
  notificaByID("/notifica/get"),
  notificheByCF("/notifica/getByPaziente"),
  terapiaByCF("/terapia/getByPaziente"),
  sendFeedback("/feedback/send"),
  afByCF("/assunzioneFarmaco/getByPaziente"),
  getPaziente("/paziente/get"),
  dottByPCF("/dottore/getByPaziente"),
  farmacoByID("/farmaco/get"),
  lastGlicemia("/glicemia/getLast"),
  glicemiaInRange("/glicemia/getRange");

  final String value;

  const ApiEndPoints(this.value);
}

import 'package:glucose_guardian/constants/general.dart';

/// 3 for prod server, 2 for staging, 1 (or everything else for development/debug)
const String kApiUrl = kAppStatus == 3
    ? "prod"
    : kAppStatus == 2
        ? "https://api.glucoseguardian.it"
        : "http://127.0.0.1:3000";

enum ApiEndPoints {
  login("/auth/login"),
  notificaByID("/notifica/get"),
  notifiche("/notifica/getAll"),
  terapiaByCF("/terapia/getByPaziente"),
  sendFeedback("/feedback/send"),
  sendNotifica("/notifica/send"),
  updateNotifica("/notifica/updateStato"),
  sendGlicemia("/glicemia/send"),
  afByCF("/assunzioneFarmaco/getByPaziente"),
  getPaziente("/paziente/get"),
  dottByPCF("/dottore/getByPaziente"),
  tutByPCF("/tutore/getByPaziente"),
  farmacoByID("/farmaco/get"),
  lastGlicemia("/glicemia/getLast"),
  glicemiaInRange("/glicemia/getRange"),
  getTutore("/tutore/get"),
  changePassword("/auth/changePw");

  final String value;

  const ApiEndPoints(this.value);
}

const String kApiUrl = "http://127.0.0.1:3000";

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

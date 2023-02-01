import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/models/auth.dart';
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/models/farmaco.dart';
import 'package:glucose_guardian/models/feedback.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/models/terapia.dart';

abstract class ApiMixin {
  Future<LoginOutput> performLogin(LoginInput data);
  Future<LoginOutput> performLoginOtp(LoginInput data);

  Future<Notifica> fetchNotificaByID(int id);
  Future<List<Notifica>> fetchNotificheByCF(String codiceFiscale);

  Future<Terapia> fetchTerapiaByCF(String codiceFiscale);

  // TODO: this doesn't return Feedback
  Future<Feedback> sendFeedback(FeedbackInput input);

  Future<List<AssunzioneFarmaco>> fetchAssunzioneFarmacoByCF(
      String codiceFiscale);

  Future<Paziente> fetchLoggedPaziente();

  Future<Dottore> fetchDottoreByPazienteCF(String codiceFiscale);

  Future<Farmaco> fetchFarmacoByID(int id);

  Future<Glicemia> fetchLastGlicemia(String codiceFiscale);
  Future<List<Glicemia>> fetchGlicemiaInRange(
      String codiceFiscale, int startTimestamp, int endTimestamp);
}

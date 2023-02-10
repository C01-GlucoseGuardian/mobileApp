import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/models/auth.dart';
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/models/farmaco.dart';
import 'package:glucose_guardian/models/feedback.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/models/terapia.dart';
import 'package:glucose_guardian/models/tutore.dart';
import 'package:glucose_guardian/services/api_mixin.dart';
import 'package:glucose_guardian/services/api_provider.dart';

class ApiRepository implements ApiMixin {
  final ApiProvider provider;

  ApiRepository(this.provider);

  @override
  Future<List<AssunzioneFarmaco>> fetchAssunzioneFarmacoByCF(
      String codiceFiscale) {
    return provider.fetchAssunzioneFarmacoByCF(codiceFiscale);
  }

  @override
  Future<Dottore> fetchDottoreByPazienteCF(String codiceFiscale) {
    return provider.fetchDottoreByPazienteCF(codiceFiscale);
  }

  @override
  Future<List<Tutore>> fetchTutoreByPazienteCF(String codiceFiscale) {
    return provider.fetchTutoreByPazienteCF(codiceFiscale);
  }

  @override
  Future<Farmaco> fetchFarmacoByID(int id) {
    return provider.fetchFarmacoByID(id);
  }

  @override
  Future<List<Glicemia>> fetchGlicemiaInRange(
      String codiceFiscale, int startTimestamp, int endTimestamp) {
    return provider.fetchGlicemiaInRange(
        codiceFiscale, startTimestamp, endTimestamp);
  }

  @override
  Future<Glicemia> fetchLastGlicemia(String codiceFiscale) {
    return provider.fetchLastGlicemia(codiceFiscale);
  }

  @override
  Future<Paziente> fetchLoggedPaziente(String codiceFiscale) {
    return provider.fetchLoggedPaziente(codiceFiscale);
  }

  @override
  Future<List<Notifica>> fetchNotificheByCF() {
    return provider.fetchNotificheByCF();
  }

  @override
  Future<Notifica> fetchNotificaByID(int id) {
    return provider.fetchNotificaByID(id);
  }

  @override
  Future archiveNotifica(Notifica notifica) {
    return provider.archiveNotifica(notifica);
  }

  @override
  Future readNotifica(Notifica notifica) {
    return provider.readNotifica(notifica);
  }

  @override
  Future receiveNotifica(Notifica notifica) {
    return provider.receiveNotifica(notifica);
  }

  @override
  Future sendNotifica(Notifica notifica) {
    return provider.sendNotifica(notifica);
  }

  @override
  Future<Terapia> fetchTerapiaByCF(String codiceFiscale) {
    return provider.fetchTerapiaByCF(codiceFiscale);
  }

  @override
  Future<LoginOutput> performLogin(LoginInput data) {
    return provider.performLogin(data);
  }

  @override
  Future<LoginOutput> performLoginOtp(LoginInput data) {
    return provider.performLoginOtp(data);
  }

  @override
  Future<bool> sendFeedback(FeedbackInput input) {
    return provider.sendFeedback(input);
  }

  @override
  Future sendGlicemia(Glicemia glicemia) {
    return provider.sendGlicemia(glicemia);
  }

  @override
  Future<Tutore> fetchLoggedTutore(String codiceFiscale) {
    return provider.fetchLoggedTutore(codiceFiscale);
  }

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) {
    return provider.changePassword(oldPassword, newPassword);
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/models/auth.dart';
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/models/farmaco.dart';
import 'package:glucose_guardian/models/feedback.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/models/terapia.dart';
import 'package:glucose_guardian/services/api_provider.dart';
import 'package:glucose_guardian/services/api_repository.dart';

void main() {
  group('Api test with localhost server', () {
    final ApiRepository api = ApiRepository(ApiProvider());

    test('api.fetchAssunzioneFarmacoByCF', () async {
      List<AssunzioneFarmaco> res =
          await api.fetchAssunzioneFarmacoByCF("ABAB");
      res.forEach((f) => print(f.toJson()));
    });

    test('api.fetchDottoreByPazienteCF', () async {
      Dottore res = await api.fetchDottoreByPazienteCF("ABAB");
      print(res.toJson());
    });

    test('api.fetchFarmacoByID', () async {
      Farmaco res = await api.fetchFarmacoByID(2);
      print(res.toJson());
    });

    test('api.fetchGlicemiaInRange', () async {
      List<Glicemia> res =
          await api.fetchGlicemiaInRange("ABAB", 120020202, 201002021);
      res.forEach((f) => print(f.toJson()));
    });

    test('api.fetchLastGlicemia', () async {
      Glicemia res = await api.fetchLastGlicemia("ABAB");
      print(res.toJson());
    });

    test('api.fetchLoggedPaziente', () async {
      Paziente res = await api.fetchLoggedPaziente();
      print(res.toJson());
    });

    test('api.fetchNotificheByCF', () async {
      List<Notifica> res = await api.fetchNotificheByCF("ABAB");
      res.forEach((f) => print(f.toJson()));
    });

    test('api.fetchNotificaByID', () async {
      Notifica res = await api.fetchNotificaByID(2);
      print(res.toJson());
    });

    test('api.fetchTerapiaByCF', () async {
      Terapia res = await api.fetchTerapiaByCF("ABAB");
      print(res.toJson());
    });

    test('api.performLogin', () async {
      LoginOutput res =
          await api.performLogin(LoginInput(email: "a", password: "a"));
      print(res.toJson());
    });

    test('api.performLoginOtp', () async {
      LoginOutput res = await api
          .performLoginOtp(LoginInput(email: "a", password: "a", otp: 123));
      print(res.toJson());
    });

    test('api.sendFeedback', () async {
      Feedback res = await api.sendFeedback(FeedbackInput(
          statoSalute: "as", oreSonno: "as", dolori: "as", svenimenti: "as"));
      print(res.toJson());
    });
  });
}

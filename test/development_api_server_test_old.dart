/*import 'package:flutter/foundation.dart';
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
      for (var f in res) {
        debugPrint(f.toJson().toString());
      }
    });

    test('api.fetchDottoreByPazienteCF', () async {
      Dottore res = await api.fetchDottoreByPazienteCF("ABAB");
      debugPrint(res.toJson().toString());
    });

    test('api.fetchFarmacoByID', () async {
      Farmaco res = await api.fetchFarmacoByID(2);
      debugPrint(res.toJson().toString());
    });

    test('api.fetchGlicemiaInRange', () async {
      List<Glicemia> res =
          await api.fetchGlicemiaInRange("ABAB", 120020202, 201002021);
      for (var f in res) {
        debugPrint(f.toJson().toString());
      }
    });

    test('api.fetchLastGlicemia', () async {
      Glicemia res = await api.fetchLastGlicemia("ABAB");
      debugPrint(res.toJson().toString());
    });

    test('api.fetchLoggedPaziente', () async {
      Paziente res = await api.fetchLoggedPaziente("ABAB");
      debugPrint(res.toJson().toString());
    });

    test('api.fetchNotificheByCF', () async {
      List<Notifica> res = await api.fetchNotificheByCF("ABAB");
      for (var f in res) {
        debugPrint(f.toJson().toString());
      }
    });

    test('api.fetchNotificaByID', () async {
      Notifica res = await api.fetchNotificaByID(2);
      debugPrint(res.toJson().toString());
    });

    test('api.fetchTerapiaByCF', () async {
      Terapia res = await api.fetchTerapiaByCF("ABAB");
      debugPrint(res.toJson().toString());
    });

    test('api.performLogin', () async {
      LoginOutput res =
          await api.performLogin(LoginInput(email: "a", password: "a"));
      debugPrint(res.toJson().toString());
    });

    test('api.performLoginOtp', () async {
      LoginOutput res = await api
          .performLoginOtp(LoginInput(email: "a", password: "a", otp: 123));
      debugPrint(res.toJson().toString());
    });

    test('api.sendFeedback', () async {
      Feedback res = await api.sendFeedback(FeedbackInput(
          statoSalute: "as", oreSonno: "as", dolori: "as", svenimenti: "as"));
      debugPrint(res.toJson().toString());
    });
  }, skip: true);
}
*/
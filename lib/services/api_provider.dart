import 'package:dio/dio.dart';
import 'package:glucose_guardian/models/terapia.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/models/feedback.dart';
import 'package:glucose_guardian/models/farmaco.dart';
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/models/auth.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/services/api_mixin.dart';

class ApiProvider implements ApiMixin {
  final Dio _client = Dio();

  @override
  Future<List<AssunzioneFarmaco>> fetchAssunzioneFarmacoByCF(
      String codiceFiscale) {
    // TODO: implement fetchAssunzioneFarmacoByCF
    throw UnimplementedError();
  }

  @override
  Future<Dottore> fetchDottoreByPazienteCF(String codiceFiscale) {
    // TODO: implement fetchDottoreByPazienteCF
    throw UnimplementedError();
  }

  @override
  Future<Farmaco> fetchFarmacoByID(int id) {
    // TODO: implement fetchFarmacoByID
    throw UnimplementedError();
  }

  @override
  Future<List<Glicemia>> fetchGlicemiaInRange(
      String codiceFiscale, int startTimestamp, int endTimestamp) {
    // TODO: implement fetchGlicemiaInRange
    throw UnimplementedError();
  }

  @override
  Future<Glicemia> fetchLastGlicemia() {
    // TODO: implement fetchLastGlicemia
    throw UnimplementedError();
  }

  @override
  Future<Paziente> fetchLoggedPaziente() {
    // TODO: implement fetchLoggedPaziente
    throw UnimplementedError();
  }

  @override
  Future<Notifica> fetchNotificaByCF(String codiceFiscale) {
    // TODO: implement fetchNotificaByCF
    throw UnimplementedError();
  }

  @override
  Future<Notifica> fetchNotificaByID(int id) {
    // TODO: implement fetchNotificaByID
    throw UnimplementedError();
  }

  @override
  Future<Terapia> fetchTerapiaByCF(String codiceFiscale) {
    // TODO: implement fetchTerapiaByCF
    throw UnimplementedError();
  }

  @override
  Future<LoginOutput> performLogin(LoginInput data) {
    // TODO: implement performLogin
    throw UnimplementedError();
  }

  @override
  Future<LoginOutput> performLoginOtp(LoginInput data) {
    // TODO: implement performLoginOtp
    throw UnimplementedError();
  }

  @override
  Future<Feedback> sendFeedback(FeedbackInput input) {
    // TODO: implement sendFeedback
    throw UnimplementedError();
  }
}

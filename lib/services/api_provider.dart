import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:glucose_guardian/constants/api.dart';
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
  final Dio _client;

  /// This should be set after login
  /// or at startup (after loading token from sharedPreferences)
  String? _bearerToken;

  set bearerToken(String value) => _bearerToken = value;

  ApiProvider({Dio? client})
      : _client = client ??
            Dio(
              BaseOptions(
                baseUrl: kApiUrl,
                connectTimeout: 10000,
                receiveTimeout: 10000,
                contentType: "application/json",
                responseType: ResponseType.json,
              ),
            );

  //TODO: error handling
  @override
  Future<List<AssunzioneFarmaco>> fetchAssunzioneFarmacoByCF(
      String codiceFiscale) async {
    var resp = await _makePostRequest(path: ApiEndPoints.afByCF.value, body: {
      "codiceFiscale": codiceFiscale,
    });

    return ((resp.data as Map)["list"] as List)
        .map<AssunzioneFarmaco>((af) => AssunzioneFarmaco.fromJson(af))
        .toList();
  }

  //TODO: error handling
  @override
  Future<Dottore> fetchDottoreByPazienteCF(String codiceFiscale) async {
    var resp =
        await _makePostRequest(path: ApiEndPoints.dottByPCF.value, body: {
      "codiceFiscale": codiceFiscale,
    });

    return Dottore.fromJson(resp.data);
  }

  //TODO: error handling
  @override
  Future<Farmaco> fetchFarmacoByID(int id) async {
    var resp =
        await _makePostRequest(path: ApiEndPoints.farmacoByID.value, body: {
      "id": id,
    });

    return Farmaco.fromJson(resp.data);
  }

  //TODO: error handling
  @override
  Future<List<Glicemia>> fetchGlicemiaInRange(
      String codiceFiscale, int startTimestamp, int endTimestamp) async {
    var resp = await _makePostRequest(
        path: ApiEndPoints.glicemiaInRange.value,
        body: {
          "idPaziente": codiceFiscale,
          "start": startTimestamp,
          "end": endTimestamp
        });

    return ((resp.data as Map)["list"] as List)
        .map<Glicemia>((af) => Glicemia.fromJson(af))
        .toList();
  }

  //TODO: error handling
  @override
  Future<Glicemia> fetchLastGlicemia(String codiceFiscale) async {
    var resp =
        await _makePostRequest(path: ApiEndPoints.lastGlicemia.value, body: {
      "idPaziente": codiceFiscale,
    });

    return Glicemia.fromJson(resp.data);
  }

  //TODO: error handling
  @override
  Future<Paziente> fetchLoggedPaziente() async {
    var resp = await _makeRequest(
      path: ApiEndPoints.getPaziente.value,
    );

    return Paziente.fromJson(resp.data);
  }

  //TODO: error handling
  @override
  Future<List<Notifica>> fetchNotificheByCF(String codiceFiscale) async {
    var resp =
        await _makePostRequest(path: ApiEndPoints.notificheByCF.value, body: {
      "codiceFiscale": codiceFiscale,
    });

    return ((resp.data as Map)["list"] as List)
        .map<Notifica>((af) => Notifica.fromJson(af))
        .toList();
  }

  //TODO: error handling
  @override
  Future<Notifica> fetchNotificaByID(int id) async {
    var resp =
        await _makePostRequest(path: ApiEndPoints.notificaByID.value, body: {
      "id": id,
    });

    return Notifica.fromJson(resp.data);
  }

  //TODO: error handling
  @override
  Future<Terapia> fetchTerapiaByCF(String codiceFiscale) async {
    var resp =
        await _makePostRequest(path: ApiEndPoints.terapiaByCF.value, body: {
      "codiceFiscale": codiceFiscale,
    });

    return Terapia.fromJson(resp.data);
  }

  //TODO:
  @override
  Future<LoginOutput> performLogin(LoginInput data) async {
    var resp = await _makePostRequest(
        path: ApiEndPoints.login.value, body: data.toJson());

    return LoginOutput.fromJson(resp.data);
  }

  //TODO:
  @override
  Future<LoginOutput> performLoginOtp(LoginInput data) async {
    var resp = await _makePostRequest(
        path: ApiEndPoints.loginOtp.value, body: data.toJson());

    return LoginOutput.fromJson(resp.data);
  }

  //TODO: error handling
  @override
  Future<Feedback> sendFeedback(FeedbackInput input) async {
    var resp = await _makePostRequest(
        path: ApiEndPoints.sendFeedback.value, body: input.toJson());

    return Feedback.fromJson(resp.data);
  }

  /// Utility function for get requests
  ///
  /// TODO: error handling
  Future<Response> _makeRequest({
    required String path,
    bool generic = false,
  }) async {
    debugPrint("Url => ${kApiUrl + path}");

    if (!generic) {
      _client.options.headers['authorization'] = "Bearer $_bearerToken";
    }
    return await _client.get(path);
  }

  /// Utility function for post requests
  ///
  /// TODO: error handling
  Future<Response> _makePostRequest({
    required String path,
    required Map body,
    bool generic = false,
  }) async {
    debugPrint("Url => ${kApiUrl + path}");

    if (!generic) {
      _client.options.headers['authorization'] = "Bearer $_bearerToken";
    }
    return await _client.post(path, data: body);
  }
}

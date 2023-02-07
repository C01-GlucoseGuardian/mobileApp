import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:glucose_guardian/constants/api.dart';
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
import 'package:glucose_guardian/services/exceptions/api_exception.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

class ApiProvider implements ApiMixin {
  final Dio _client;

  /// This should be set after login
  /// or at startup (after loading token from sharedPreferences)

  ApiProvider({Dio? client})
      : _client = client ??
            Dio(
              BaseOptions(
                baseUrl: SharedPreferenceService.customApiUrl.isNotEmpty
                    ? SharedPreferenceService.customApiUrl
                    : kApiUrl,
                connectTimeout: 10000,
                receiveTimeout: 10000,
                contentType: "application/json",
                responseType: ResponseType.json,
              ),
            );

  @override
  Future<List<AssunzioneFarmaco>> fetchAssunzioneFarmacoByCF(
      String codiceFiscale) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.afByCF.value,
      body: {
        "codiceFiscale": codiceFiscale,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return ((resp.data as Map)["list"] as List)
        .map<AssunzioneFarmaco>((af) => AssunzioneFarmaco.fromJson(af))
        .toList();
  }

  @override
  Future<Dottore> fetchDottoreByPazienteCF(String codiceFiscale) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.dottByPCF.value,
      body: {
        "codiceFiscale": codiceFiscale,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return Dottore.fromJson(resp.data);
  }

  @override
  Future<Farmaco> fetchFarmacoByID(int id) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.farmacoByID.value,
      body: {
        "id": id,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return Farmaco.fromJson(resp.data);
  }

  @override
  Future<List<Glicemia>> fetchGlicemiaInRange(
      String codiceFiscale, int startTimestamp, int endTimestamp) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.glicemiaInRange.value,
      body: {
        "idPaziente": codiceFiscale,
        "start": startTimestamp,
        "end": endTimestamp
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return ((resp.data as Map)["list"] as List)
        .map<Glicemia>((af) => Glicemia.fromJson(af))
        .toList();
  }

  @override
  Future<Glicemia> fetchLastGlicemia(String codiceFiscale) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.lastGlicemia.value,
      body: {
        "idPaziente": codiceFiscale,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return Glicemia.fromJson(resp.data);
  }

  @override
  Future<Paziente> fetchLoggedPaziente(String codiceFiscale) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.getPaziente.value,
      body: {
        "codiceFiscale": codiceFiscale,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return Paziente.fromJson(resp.data);
  }

  @override
  Future<List<Notifica>> fetchNotificheByCF(String codiceFiscale) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.notificheByCF.value,
      body: {
        "codiceFiscale": codiceFiscale,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return ((resp.data as Map)["list"] as List)
        .map<Notifica>((af) => Notifica.fromJson(af))
        .toList();
  }

  @override
  Future<Notifica> fetchNotificaByID(int id) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.notificaByID.value,
      body: {
        "id": id,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return Notifica.fromJson(resp.data);
  }

  @override
  Future<Terapia> fetchTerapiaByCF(String codiceFiscale) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.terapiaByCF.value,
      body: {
        "codiceFiscale": codiceFiscale,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return Terapia.fromJson(resp.data);
  }

  @override
  Future<LoginOutput> performLogin(LoginInput data) async {
    var resp;
    try {
      resp = await _makePostRequest(
          path: ApiEndPoints.login.value, body: data.toJson());
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw NeedsOTPApiException();
      }

      if (e.response?.statusCode != 200) {
        throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
      }
    }
    return LoginOutput.fromJson(resp.data);
  }

  @override
  Future<LoginOutput> performLoginOtp(LoginInput data) async {
    return performLogin(data);
  }

  @override
  Future<Feedback> sendFeedback(FeedbackInput input) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.sendFeedback.value,
      body: input.toJson(),
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return Feedback.fromJson(resp.data);
  }

  @override
  Future<Tutore> fetchLoggedTutore(String codiceFiscale) async {
    var resp = await _makePostRequest(
      path: ApiEndPoints.getTutore.value,
      body: {
        "codiceFiscale": codiceFiscale,
      },
      generic: false,
    );

    debugPrint(resp.toString());

    if (resp.statusCode != 200) {
      throw ApiException(msg: resp.data['msg'] ?? "Eccezione non gestita");
    }

    return Tutore.fromJson(resp.data);
  }

  /// Utility function for post requests
  Future<Response> _makePostRequest({
    required String path,
    required Map body,
    bool generic = true,
  }) async {
    debugPrint("Url => ${kApiUrl + path}\nBody => $body");

    if (!generic) {
      _client.options.headers['authorization'] =
          "Bearer ${SharedPreferenceService.bearerToken}";
    }
    return await _client.post(path, data: body);
  }
}

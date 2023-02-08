import 'package:shared_preferences/shared_preferences.dart';

/// Utility class for SharedPreferences.
///
/// It creates a singleton in order to have it in the whole widget tree without
/// calling SharedPreferences.getInstance() multiple times.
/// Easily modifiable to hold maybe a volatile cache of the preferences.
class SharedPreferenceService {
  /// Contains the SharedPreferences instance field,
  /// created by [SharedPreferenceService.init]
  static late final SharedPreferences _instance;

  static const String _kFirstTimeOpeningApp = "firstTimeOpeningApp";
  static const String _kBearerToken = "bearerToken";
  static const String _kUserType = "userType";
  static const String _kCodiceFiscale = "codiceFiscale";
  static const String _kCgmConnected = "cgmConnected";
  static const String _kLastSavedAgenda = "lastSavedAgenda";

  /// Creates [SharedPreferenceService._instance], this should be called in the
  /// main function after `WidgetsFlutterBinding.ensureInitialized()`
  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  /// returns true if the user is opening the app for
  /// the first time (fresh install)
  static bool get firstTimeOpeningApp =>
      _instance.getBool(_kFirstTimeOpeningApp) ?? true;

  /// This should be set to false after the landing page only once
  static set firstTimeOpeningApp(bool value) =>
      _instance.setBool(_kFirstTimeOpeningApp, value);

  /// Checks if there's a bearer token saved in shared preferences,
  /// returns true if there's something, false otherwise.
  static bool get isLogged => _instance.getString(_kBearerToken) != null;

  /// Used by login to save bearerToken string
  static set bearerToken(String value) =>
      _instance.setString(_kBearerToken, value);

  /// Get bearerToken
  static String get bearerToken => _instance.getString(_kBearerToken) ?? "";

  /// Get user type, 2 is paziente, 3 is tutore.
  /// We assume that this is called after [userType] setter
  static UserType get userType =>
      UserType.values[_instance.getInt(_kUserType)!];

  /// Set user type
  static set userType(UserType type) =>
      _instance.setInt(_kUserType, type.index);

  /// Set after first login, cleared by eventual log out
  static String? get codiceFiscale => _instance.getString(_kCodiceFiscale);

  /// Set after first login
  ///
  /// HACK: since set and get should have the same type,
  /// this setter gets a String? but it should never be null
  static set codiceFiscale(String? value) =>
      _instance.setString(_kCodiceFiscale, value!);

  /// Save connected CGM
  static set connectedCgm(String value) =>
      _instance.setString(_kCgmConnected, value);

  /// Get connected CGM
  static String get connectedCgm => _instance.getString(_kCgmConnected) ?? "";

  /// Last saved agenda msSinceEpoch
  static int get lastSavedAgenda => _instance.getInt(_kLastSavedAgenda) ?? 0;

  /// Last saved agenda msSinceEpoch
  static set lastSavedAgenda(int value) =>
      _instance.setInt(_kLastSavedAgenda, value);

  /// Log out
  static void logout() {
    _instance.remove(_kCgmConnected);
    _instance.remove(_kCodiceFiscale);
    _instance.remove(_kUserType);
    _instance.remove(_kBearerToken);
  }

  /// NSA/Andrea Mennillo control zone
  /// This sets/gets custom api url
  static set customApiUrl(String value) => _instance.setString("api", value);
  static String get customApiUrl => _instance.getString("api") ?? "";
}

enum UserType { paziente, tutore }

enum FirstScreenState {
  neverOpenedApp,
  openedAppButNotLogged,
  loggedAsPaziente,
  loggedAsTutore
}

FirstScreenState getFirstScreenState() {
  if (SharedPreferenceService.firstTimeOpeningApp) {
    return FirstScreenState.neverOpenedApp;
  } else if (SharedPreferenceService.isLogged) {
    if (SharedPreferenceService.userType == UserType.paziente) {
      return FirstScreenState.loggedAsPaziente;
    } else if (SharedPreferenceService.userType == UserType.tutore) {
      return FirstScreenState.loggedAsTutore;
    }
  } else {
    return FirstScreenState.openedAppButNotLogged;
  }

  // this should never happen, but hey, linter ¯\_(ツ)_/¯
  return FirstScreenState.openedAppButNotLogged;
}

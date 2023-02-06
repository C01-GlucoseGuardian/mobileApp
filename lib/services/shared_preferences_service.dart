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

  /// Get user type, 0 is paziente, 1 is tutore.
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
  /// HACK: this setter gets a String? but it should never be null
  static set codiceFiscale(String? value) =>
      _instance.setString(_kCodiceFiscale, value!);

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

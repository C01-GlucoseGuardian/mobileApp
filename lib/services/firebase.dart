import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

void askNotificationPermission(BuildContext context) {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging
      .requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  )
      .then(
    (value) {
      if (value.authorizationStatus != AuthorizationStatus.authorized) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: "Non riceverai le notifiche.",
        );
      }
    },
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
}

void listenOnActiveApp(BuildContext context) async {
  await FirebaseMessaging.instance
      .subscribeToTopic(SharedPreferenceService.codiceFiscale!);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      title: message.data['title'] ?? "Nuova notifica!",
      desc: message.data['message'] != null
          ? "Messaggio: ${message.data['message']}"
          : "",
    ).show();
  });
}

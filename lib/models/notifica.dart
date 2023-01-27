import 'package:flutter/material.dart';

class Notifica {
  final String message;
  final DateTime date;
  final TimeOfDay time;

  final StatoNotifica status;

  Notifica(this.message, this.date, this.time, this.status);
}

enum StatoNotifica { created, sent, received, read, dismissed }

extension StatoNotificaExtension on StatoNotifica {
  int get value {
    switch (this) {
      case StatoNotifica.created:
        return 0;
      case StatoNotifica.sent:
        return 1;
      case StatoNotifica.received:
        return 2;
      case StatoNotifica.read:
        return 3;
      case StatoNotifica.dismissed:
        return 4;
    }
  }
}

StatoNotifica statoNotificaFromInt(int status) {
  switch (status) {
    case 0:
      return StatoNotifica.created;
    case 1:
      return StatoNotifica.sent;
    case 2:
      return StatoNotifica.received;
    case 3:
      return StatoNotifica.read;
    case 4:
    default:
      return StatoNotifica.dismissed;
  }
}

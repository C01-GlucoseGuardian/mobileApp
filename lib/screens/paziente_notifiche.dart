import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:intl/intl.dart';

class PazienteNotifiche extends StatelessWidget {
  final List<Notifica> notifications;

  const PazienteNotifiche({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) => NotificationCard(
        notification: notifications[index],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Notifica notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: true,
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(16)),
          autoClose: true,
          onPressed: (ctx) {},
          backgroundColor: kBackgroundColor,
          foregroundColor: Theme.of(context).primaryColor,
          icon: Icons.check,
          label: 'Letto',
        ),
      ]),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 3,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: kBackgroundColor,
                  foregroundColor: kOrangePrimary,
                  child: Icon(Icons.notifications_active_rounded),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoWidget(
                    context,
                    "Data",
                    DateFormat("dd MMMM yyyy", 'it').format(notification.date),
                    Icons.access_time_rounded,
                  ),
                  _buildInfoWidget(
                    context,
                    "Ora",
                    formatTime(notification.time),
                    Icons.access_time_rounded,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(notification.message),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildInfoWidget(
      BuildContext context, String text, String subtitle, IconData? icon,
      {Widget? iconAlt}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        icon != null
            ? Icon(
                icon,
                size: 16,
                color: Theme.of(context).primaryColor,
              )
            : iconAlt!,
        const Padding(
          padding: EdgeInsets.only(left: 8),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        )
      ],
    );
  }
}
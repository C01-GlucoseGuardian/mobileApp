import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/bloc/notifications/notifications_bloc.dart';
import 'package:glucose_guardian/components/empty_data.dart';
import 'package:glucose_guardian/components/error_screen.dart';
import 'package:glucose_guardian/components/loading.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:intl/intl.dart';

class PazienteNotifiche extends StatefulWidget {
  const PazienteNotifiche({super.key});

  @override
  State<PazienteNotifiche> createState() => _PazienteNotificheState();
}

class _PazienteNotificheState extends State<PazienteNotifiche> {
  final NotificationsBloc _bloc = NotificationsBloc();

  @override
  void initState() {
    _bloc.add(GetNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsInitial || state is NotificationsLoading) {
            return const Loading(
              child: CircleAvatar(
                backgroundColor: kBackgroundColor,
                child: Icon(
                  Icons.notifications_active_rounded,
                  size: 20,
                  color: kOrangePrimary,
                ),
              ),
            );
          } else if (state is NotificationsLoaded) {
            List<Notifica> notifications = state.notifications;

            return _buildContent(notifications);
          } else {
            if (state is NotificationsError) {
              return const ErrorScreen(text: "Errore");
            }
            return const ErrorScreen(text: "Errore");
          }
        },
      ),
    );
  }

  StatelessWidget _buildContent(List<Notifica> notifications) {
    if (notifications.isEmpty) {
      return const EmptyData(text: "Non ci sono notifiche recenti!");
    }
    DateTime fromDateAndTime(DateTime date, TimeOfDay time) =>
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    notifications.sort(
      (a, b) => fromDateAndTime(b.data!, b.time!).compareTo(
        fromDateAndTime(a.data!, a.time!),
      ),
    );

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) => NotificationCard(
        notification: notifications[index],
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final Notifica notification;

  const NotificationCard({super.key, required this.notification});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Slidable(
        enabled: enabled,
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(16)),
            autoClose: true,
            onPressed: (ctx) {
              api.archiveNotifica(widget.notification);

              setState(() {
                enabled = false;
              });
            },
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
                      DateFormat("dd MMMM yyyy", 'it')
                          .format(widget.notification.data!),
                      Icons.access_time_rounded,
                    ),
                    _buildInfoWidget(
                      context,
                      "Ora",
                      formatTime(widget.notification.time!),
                      Icons.access_time_rounded,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(widget.notification.messaggio!),
                  ],
                ),
              )
            ],
          ),
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

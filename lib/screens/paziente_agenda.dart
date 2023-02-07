import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glucose_guardian/bloc/agenda/agenda_bloc.dart';
import 'package:glucose_guardian/components/empty_data.dart';
import 'package:glucose_guardian/components/error_screen.dart';
import 'package:glucose_guardian/components/loading.dart';
import 'package:glucose_guardian/constants/assets.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/screens/paziente_doctor_screen.dart';

class PazienteAgenda extends StatefulWidget {
  const PazienteAgenda({super.key});

  @override
  State<PazienteAgenda> createState() => _PazienteAgendaState();
}

class _PazienteAgendaState extends State<PazienteAgenda> {
  final AgendaBloc _bloc = AgendaBloc();

  @override
  void initState() {
    _bloc.add(GetAgenda());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<AgendaBloc, AgendaState>(
        builder: (context, state) {
          if (state is AgendaInitial || state is AgendaLoading) {
            return Loading(
              child: CircleAvatar(
                backgroundColor: kBackgroundColor,
                child: SvgPicture.asset(
                  kPrescriptionsIcon,
                  color: kOrangePrimary,
                  width: 28,
                  height: 28,
                ),
              ),
            );
          } else if (state is AgendaLoaded) {
            List<AssunzioneFarmaco> drugs = state.agenda;

            return _buildContent(drugs);
          } else {
            return ErrorScreen(
              text:
                  "Errore.\nMessaggio: ${state is AgendaError ? state.error : 'NON PRESENTE'}",
            );
          }
        },
      ),
    );
  }

  Column _buildContent(List<AssunzioneFarmaco> drugs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 16),
          child: SendFeedbackButton(),
        ),
        if (drugs.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: drugs.length,
              itemBuilder: (context, index) => DrugCard(
                assunzioneFarmaco: drugs[index],
              ),
            ),
          ),
        if (drugs.isEmpty) const EmptyData(text: "L'agenda è vuota!"),
      ],
    );
  }
}

class DrugCard extends StatefulWidget {
  final AssunzioneFarmaco assunzioneFarmaco;
  final bool enabled;

  const DrugCard(
      {super.key, required this.assunzioneFarmaco, this.enabled = true});

  @override
  State<DrugCard> createState() => _DrugCardState();
}

class _DrugCardState extends State<DrugCard> {
  late bool enabled;

  @override
  void initState() {
    enabled = widget.enabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Slidable(
        enabled: enabled,
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(16)),
            autoClose: true,
            onPressed: (ctx) {
              setState(() {
                enabled = !enabled;
              });
            },
            backgroundColor: kBackgroundColor,
            foregroundColor: Theme.of(context).primaryColor,
            icon: Icons.check,
            label: 'Presa',
          ),
        ]),
        child: Container(
          width: double.infinity,
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: kBackgroundColor,
                    child: SvgPicture.asset(
                      kPrescriptionsIcon,
                      color: kOrangePrimary,
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.assunzioneFarmaco.nomeFarmaco ?? "NON PRESENTE",
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.clip,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildInfoWidget(
                      context,
                      "Orario Assunzione",
                      widget.assunzioneFarmaco.orarioAssunzione != null
                          ? formatTime(
                              widget.assunzioneFarmaco.orarioAssunzione!)
                          : "NON PRESENTE",
                      Icons.access_time_rounded,
                    ),
                    _buildInfoWidget(
                      context,
                      "Dose",
                      "${widget.assunzioneFarmaco.dosaggio!} mg",
                      null,
                      iconAlt: SvgPicture.asset(
                        kSyringeIcon,
                        color: Theme.of(context).primaryColor,
                        width: 16,
                        height: 16,
                      ),
                    ),
                    _buildInfoWidget(
                      context,
                      "Via di somministrazione",
                      widget.assunzioneFarmaco.viaDiSomministrazione ??
                          "NON PRESENTE",
                      Icons.remove_red_eye_rounded,
                    ),
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

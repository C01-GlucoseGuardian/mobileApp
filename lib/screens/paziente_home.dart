import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glucose_guardian/_mock_data.dart';
import 'package:glucose_guardian/components/day_selector.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/Measurement.dart';
import 'package:glucose_guardian/models/user.dart';

class PazienteHome extends StatelessWidget {
  const PazienteHome({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _createAppBar(),
      body: Column(
        children: [
          const DaySelector(),
          GlucoseCard(
            measurementsOfSelectedDay: kMockMeasurements,
          ),
          const Expanded(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }

  AppBar _createAppBar() => AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Text("Ciao, ${user.nome}!"),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {}, // TODO: bring user to CGM Selector page
            icon: const Icon(
              Icons.light_outlined, // TODO: correct icon for CGM Selector
            ),
          ),
        ],
      );
}

class GlucoseCard extends StatefulWidget {
  final List<Measurement> measurementsOfSelectedDay;
  const GlucoseCard({super.key, required this.measurementsOfSelectedDay});

  @override
  State<GlucoseCard> createState() => _GlucoseCardState();
}

class _GlucoseCardState extends State<GlucoseCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // assuming they're already sorted by date, last is least measurement
    Measurement last = widget.measurementsOfSelectedDay.last;
    Measurement lower = widget.measurementsOfSelectedDay.reduce(
        (value, element) => value.value < element.value ? value : element);
    Measurement higher = widget.measurementsOfSelectedDay.reduce(
        (value, element) => value.value > element.value ? value : element);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      height: isExpanded ? 200 : 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: InkWell(
        onTap: () => setState(() => isExpanded = !isExpanded),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: kBackgroundColor,
                    foregroundColor: Colors.black,
                    child: Icon(
                      Icons.light_outlined,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Glucosio: ${last.value.toStringAsFixed(1)} mmol/L",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        isGlucoseValueNormal(last.value)
                            ? "Ti dovresti sentire bene!"
                            : "Fai attenzione al livello di glucosio!",
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                  )
                ],
              ),
            ),
            if (isExpanded)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMaxMinNormalWidget(
                        higher, Icons.arrow_upward_rounded, "Alto"),
                    _buildMaxMinNormalWidget(Measurement(5.5, null),
                        Icons.check_circle_sharp, "Normale"),
                    _buildMaxMinNormalWidget(
                        lower, Icons.arrow_downward_rounded, "Basso"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Row _buildMaxMinNormalWidget(Measurement higher, IconData icon, String desc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          icon,
          size: 16,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: higher.value.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: " mmol/L"),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

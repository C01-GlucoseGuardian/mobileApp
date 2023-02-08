import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/general.dart';
import 'package:glucose_guardian/models/glicemia.dart';

/// Glucose chart for a selected range of measurements
///
/// chart card
class GlucoseChartCard extends StatelessWidget {
  final List<Glicemia> measurementsOfSelectedDay;

  const GlucoseChartCard({super.key, required this.measurementsOfSelectedDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _createHeader(),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      mainBarData(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _createHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        CircleAvatar(
          backgroundColor: kBackgroundColor,
          foregroundColor: kOrangePrimary,
          child: Icon(
            Icons.bar_chart_rounded,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Text(
          'Livello glucosio',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  BarChartData mainBarData() {
    Glicemia lowest = getLowest(measurementsOfSelectedDay);
    Glicemia highest = getHighest(measurementsOfSelectedDay);

    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipBgColor: kBackgroundColor,
          tooltipRoundedRadius: 3,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            Glicemia clickedMeasurement = measurementsOfSelectedDay[groupIndex];
            return BarTooltipItem(
              "${clickedMeasurement.livelloGlucosio} $kGlucoseUOM",
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(
        drawVerticalLine: false,
      ),
      barGroups: measurementsOfSelectedDay
          .map(
            (e) => BarChartGroupData(
              x: e.timestamp!, // X axis
              barRods: [
                BarChartRodData(
                  color: isGlucoseValueNormal(e.livelloGlucosio!)
                      ? kBlue
                      : Color.lerp(
                          kOrangeGraphBase,
                          kOrangePrimary,
                          measurementsOfSelectedDay.length == 1
                              ? 1.0
                              : (e.livelloGlucosio! - lowest.livelloGlucosio!) /
                                  (highest.livelloGlucosio! -
                                      lowest.livelloGlucosio!),
                        ),
                  toY: e.livelloGlucosio!.toDouble(), // Y axis
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

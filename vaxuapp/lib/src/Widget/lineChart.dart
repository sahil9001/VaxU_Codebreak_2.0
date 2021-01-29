import 'package:vaxuapp/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineReportChart extends StatelessWidget {
  final int type;
  const LineReportChart({Key key, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getSports(type),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [kPrimaryColor],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSports(int type) {
    if (type == 1) {
      return [
        FlSpot(0, .5),
        FlSpot(1, 1.5),
        FlSpot(2, .5),
        FlSpot(3, .7),
        FlSpot(4, .2),
        FlSpot(5, 2),
        FlSpot(6, 1.5),
        FlSpot(7, 1.7),
        FlSpot(8, 1),
        FlSpot(9, 2.8),
        FlSpot(10, 2.5),
        FlSpot(11, 2.65),
      ];
    } else if (type == 2) {
      return [
        FlSpot(0, .5),
        FlSpot(1, 1.5),
        FlSpot(2, .5),
        FlSpot(3, .7),
        FlSpot(4, .2),
        FlSpot(5, 2),
        FlSpot(6, 1.5),
        FlSpot(7, 1.7),
        FlSpot(8, 0.3),
        FlSpot(9, 0.2),
        FlSpot(10, 0.2),
        FlSpot(11, 0.1),
      ];
    } else if (type == 3) {
      return [
        FlSpot(0, .5),
        FlSpot(1, 1.5),
        FlSpot(2, .5),
        FlSpot(3, .7),
        FlSpot(4, .2),
        FlSpot(5, 2),
        FlSpot(6, 1.5),
        FlSpot(7, 1.7),
        FlSpot(8, 1),
        FlSpot(9, 2.8),
        FlSpot(10, 2.5),
        FlSpot(11, 2.65),
      ];
    } else if (type == 4) {
      return [
        FlSpot(0, .5),
        FlSpot(1, 1.5),
        FlSpot(2, .5),
        FlSpot(3, .7),
        FlSpot(4, .2),
        FlSpot(5, 2),
        FlSpot(6, 1.5),
        FlSpot(7, 1.7),
        FlSpot(8, 1),
        FlSpot(9, 2.8),
        FlSpot(10, 2.5),
        FlSpot(11, 2.65),
      ];
    }
  }
}

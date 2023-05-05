import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../main.dart';

class ChartGraph extends StatefulWidget {
  const ChartGraph({super.key});

  @override
  State<ChartGraph> createState() {
    return _ChartGraphState();
  }
}

class _ChartGraphState extends State<ChartGraph> {
  List<FlSpot> chartData = [
    FlSpot(0, 3),
    FlSpot(2.6, 2),
    FlSpot(4.9, 5),
    FlSpot(6.8, 2.5),
    FlSpot(8, 4),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
    FlSpot(12, 1),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Feb', style: style);
        break;
      case 4:
        text = const Text('Mar', style: style);
        break;
      case 6:
        text = const Text('Apr', style: style);
        break;
      case 8:
        text = const Text('May', style: style);
        break;
      case 10:
        text = const Text('Jun', style: style);
        break;
      case 12:
        text = const Text('Jul', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('1k', style: style);
        break;
      case 2:
        text = const Text('2k', style: style);
        break;
      case 3:
        text = const Text('3k', style: style);
        break;
      case 4:
        text = const Text('4k', style: style);
        break;
      case 5:
        text = const Text('5k', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: mq.height * 0.35,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(enabled: false),
              lineBarsData: [
                LineChartBarData(
                  spots: chartData,
                  isCurved: true,
                  barWidth: 4,
                  color: Colors.blue,
                ),
              ],
              minY: 0,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: bottomTitleWidgets,
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: leftTitleWidgets,
                    interval: 1,
                  ),
                ),
              ),
              borderData: FlBorderData(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.5),
                    width: 2,
                  ),
                  left: BorderSide(
                    color: Colors.black.withOpacity(0.5),
                    width: 2,
                  ),
                  right: BorderSide(
                    color: Colors.transparent,
                  ),
                  top: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

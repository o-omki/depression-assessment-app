import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../api/backend_api.dart';
import '../main.dart';

// ignore: must_be_immutable
class ChartGraph extends StatefulWidget {
  ChartGraph(this.userId, {super.key});

  String userId;
  @override
  State<ChartGraph> createState() {
    return _ChartGraphState();
  }
}

class _ChartGraphState extends State<ChartGraph> {
  late List<FlSpot> chartData = [];

  late List<String> days = [];
  late List<Map<String, dynamic>> moodGraphEntries = [];
  bool _isInitialized = false;

  Future<void> _getMoodGraphEntries() async {
    moodGraphEntries = await getMoodGraphEntries(widget.userId);
  }

  List<FlSpot> _getFlSpots(List<Map<String, dynamic>> moodGraphEntries) {
    List<FlSpot> flSpots = [];
    var index = 0;
    for (var entry in moodGraphEntries) {
      flSpots.add(FlSpot((index++).toDouble(), entry['mood_score'].toDouble()));
      days.add(entry['day']);
    }

    return flSpots;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text = Text(days[value.toInt()], style: style);
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
  void initState() {
    super.initState();
    _getMoodGraphEntries().then(
      (_) {
        setState(() {
          print("Inside setState");
          chartData.addAll(_getFlSpots(moodGraphEntries));
          _isInitialized = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        SizedBox(
          height: mq.height * 0.35,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        final flSpot = barSpot;
                        if (flSpot.x == 0 || flSpot.x == 6) {
                          return null;
                        }

                        return LineTooltipItem(
                          '${flSpot.y}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),                  
                  ),
                  
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
                    reservedSize: 28,
                    getTitlesWidget: bottomTitleWidgets,
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 20,
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
                  right: const BorderSide(
                    color: Colors.transparent,
                  ),
                  top: const BorderSide(
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

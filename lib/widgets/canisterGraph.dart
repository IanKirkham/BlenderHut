import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CanisterGraph extends StatefulWidget {
  @override
  _CanisterGraphState createState() => _CanisterGraphState();
}

class _CanisterGraphState extends State<CanisterGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.blueGrey[800],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 115,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipBottomMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.y.round().toString(),
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => const TextStyle(
                      color: Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 20,
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => const TextStyle(
                      color: Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 15,
                  getTitles: (value) {
                    if (value == 0) {
                      return '0%';
                    } else if (value == 50) {
                      return '50%';
                    } else if (value == 100) {
                      return '100%';
                    } else {
                      return '';
                    }
                  },
                ),
              ),
              axisTitleData: FlAxisTitleData(
                show: true,
                bottomTitle: AxisTitle(
                  showTitle: true,
                  titleText: "Canisters",
                  textStyle: TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: getGraphData(),
            ),
          ),
        ),
      ),
    );
  }

  //TODO: make this method dynamic with data from backend
  List<BarChartGroupData> getGraphData() {
    return [
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: 15,
            colors: [Colors.lightBlueAccent, Colors.greenAccent],
            width: 13,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: 45,
            colors: [Colors.lightBlueAccent, Colors.greenAccent],
            width: 13,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: 80,
            colors: [Colors.lightBlueAccent, Colors.greenAccent],
            width: 13,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            y: 100,
            colors: [Colors.lightBlueAccent, Colors.greenAccent],
            width: 13,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            y: 32,
            colors: [Colors.lightBlueAccent, Colors.greenAccent],
            width: 13,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            y: 50,
            colors: [Colors.lightBlueAccent, Colors.greenAccent],
            width: 13,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
    ];
  }
}

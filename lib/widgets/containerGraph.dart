import 'package:blenderapp/models/containerData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ContainerGraph extends StatefulWidget {
  final Function(BuildContext, ContainerData) onBarSelected;
  ContainerGraph(this.onBarSelected);

  @override
  _ContainerGraphState createState() => _ContainerGraphState();
}

class _ContainerGraphState extends State<ContainerGraph> {
  List<ContainerData> data = [
    ContainerData('L3 - Water', 90, Colors.blue[100]),
    ContainerData('L2 - OJ', 25, Colors.orange[300]),
    ContainerData('L1 - Milk', 30, Colors.white),
    ContainerData('F6 - Strawberry', 90, Color(0xfff25f5c)),
    ContainerData('F5 - Banana', 75, Color(0xffffe066)),
    ContainerData('F4 - Ice Cream', 100, Colors.orange[100]),
    ContainerData('F3 - Peach', 15, Colors.red[200]),
    ContainerData('F2 - Raspberry', 100, Colors.pink[400]),
    ContainerData('F1 - Empty', 0, Colors.transparent),
  ];

  var _selectedIndex;

  // void _selectionChanged(args) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFF2F3D46), //Colors.blueGrey[800],
      ),
      child: SfCartesianChart(
        onDataLabelTapped: (DataLabelTapDetails args) async {
          print("Index: ${args.pointIndex}");
          print("Value: ${args.text}");
          if (args.text == "0%") {
            int res =
                await widget.onBarSelected(context, data[args.pointIndex]);
            print("Modal sheet closed with value: $res");
            if (res != null) {
              setState(() {
                data[_selectedIndex].amount = res;
              });
            }
          }
        },
        onSelectionChanged: (SelectionArgs args) async {
          if (_selectedIndex == args.pointIndex) {
            _selectedIndex = null;
            return;
          }
          _selectedIndex = args.pointIndex;
          if (widget.onBarSelected != null) {
            int res = await widget.onBarSelected(context, data[_selectedIndex]);
            print("Modal sheet closed with value: $res");
            if (res != null) {
              setState(() {
                data[_selectedIndex].amount = res;
              });
            }
          }
        },
        primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 100,
          interval: 25,
          labelFormat: '{value}%', //toStringAsFixed(0) + "%",
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        // Chart title
        title: ChartTitle(
          text: widget.onBarSelected != null ? 'Fill Containers' : 'Containers',
          // alignment: ChartAlignment.near,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: widget.onBarSelected == null ? true : false,
        ),
        series: <ChartSeries<ContainerData, String>>[
          BarSeries<ContainerData, String>(
            dataSource: data,
            xValueMapper: (ContainerData ingredients, _) =>
                ingredients.ingredient,
            yValueMapper: (ContainerData ingredients, _) => ingredients.amount,
            pointColorMapper: (ContainerData ingredients, _) =>
                ingredients.color,
            selectionBehavior: SelectionBehavior(
              enable: true,
              unselectedColor: Colors.grey,
            ),
            enableTooltip: true,
            name: 'Ingredients',
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
            ),
          ),
        ],
      ),
    );
  }
}

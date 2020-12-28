import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CanisterGraph extends StatefulWidget {
  final Function(BuildContext, double) onBarSelected;
  CanisterGraph(this.onBarSelected);

  @override
  _CanisterGraphState createState() => _CanisterGraphState();
}

class _CanisterGraphState extends State<CanisterGraph> {
  List<_IngredientData> data = [
    _IngredientData('Strawberry', 90, Colors.red),
    _IngredientData('Banana', 75, Colors.yellow),
    _IngredientData('Milk', 30, Colors.white),
    _IngredientData('Ice Cream', 100, Colors.orange[100]),
    _IngredientData('Peach', 10, Colors.red[200]),
  ];

  var _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[800],
        ),
        child: SfCartesianChart(
          onSelectionChanged: (SelectionArgs args) {
            if (_selectedIndex == args.pointIndex) {
              _selectedIndex = null;
              return;
            }
            _selectedIndex = args.pointIndex;
            if (widget.onBarSelected != null) {
              widget.onBarSelected(context, data[_selectedIndex].amount);
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
            labelFormat: '{value}%',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          // Chart title
          title: ChartTitle(
            text: 'Canisters',
            textStyle: TextStyle(color: Colors.white),
          ),
          tooltipBehavior: TooltipBehavior(
            enable: widget.onBarSelected == null ? true : false,
          ),
          series: <ChartSeries<_IngredientData, String>>[
            BarSeries<_IngredientData, String>(
              dataSource: data,
              xValueMapper: (_IngredientData ingredients, _) =>
                  ingredients.ingredient,
              yValueMapper: (_IngredientData ingredients, _) =>
                  ingredients.amount,
              pointColorMapper: (_IngredientData ingredients, _) =>
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
                useSeriesColor: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientData {
  _IngredientData(this.ingredient, this.amount, this.color);

  final String ingredient;
  double amount;
  final Color color;
}

import 'package:flutter/material.dart';
import 'package:blenderapp/models/containerData.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HorizontalBarLabelChart extends StatefulWidget {
  final Function(BuildContext, ContainerData) onBarSelected;
  final String title;
  HorizontalBarLabelChart(this.onBarSelected, {this.title = "Containers"});

  @override
  _HorizontalBarLabelChartState createState() =>
      _HorizontalBarLabelChartState();
}

class _HorizontalBarLabelChartState extends State<HorizontalBarLabelChart> {
  final List<ContainerData> data = [
    ContainerData('F1 - Empty', 0, Colors.transparent),
    ContainerData('F2 - Raspberry', 100, Colors.pink[400]),
    ContainerData('F3 - Peach', 15, Colors.red[200]),
    ContainerData('F4 - Ice Cream', 100, Colors.orange[100]),
    ContainerData('F5 - Banana', 75, Color(0xffffe066)),
    ContainerData('F6 - Strawberry', 90, Color(0xfff25f5c)),
    ContainerData('L1 - Milk', 30, Colors.white),
    ContainerData('L2 - OJ', 25, Colors.orange[300]),
    ContainerData('L3 - Water', 90, Colors.blue[100]),
  ];

  @override
  Widget build(BuildContext context) {
    final List<charts.Series> seriesList = _createSeriesData();

    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFF2F3D46), //Colors.blueGrey[800],
      ),
      child: Column(
        children: [
          Text(widget.title),
          Expanded(
            child: charts.BarChart(
              seriesList,
              animate: true,
              vertical: false,
              selectionModels: [
                charts.SelectionModelConfig(
                  changedListener: (model) async {
                    if (widget.onBarSelected != null) {
                      if (model.hasDatumSelection) {
                        print(
                            "Color is: ${model.selectedSeries[0].colorFn(model.selectedDatum[0].index)}");
                        print(
                            "Selected index: ${model.selectedDatum[0].index}");
                        print(
                            "Value of selection: ${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}");

                        // TODO: rather than checking if amount is 0, check if the cansiter at that position has a null ingredient object)
                        if (model.selectedSeries[0]
                                .measureFn(model.selectedDatum[0].index) ==
                            0) {
                          final snackbar = SnackBar(
                            content:
                                Text("Please add ingredient to canister first"),
                            backgroundColor: Colors.red,
                          );
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else {
                          int res = await widget.onBarSelected(
                              context, data[model.selectedDatum[0].index]);
                          print("Modal sheet closed with value: $res");
                          if (res != null) {
                            setState(() {
                              data[model.selectedDatum[0].index].amount = res;
                            });
                          }
                        }
                      }
                    }
                  },
                ),
              ],
              // Set a bar label decorator.
              // Example configuring different styles for inside/outside:
              //       barRendererDecorator: new charts.BarLabelDecorator(
              //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
              //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
              barRendererDecorator: new charts.BarLabelDecorator<String>(
                labelPosition: charts.BarLabelPosition.auto,
                labelAnchor: charts.BarLabelAnchor.end,
                insideLabelStyleSpec: charts.TextStyleSpec(
                  color: charts.ColorUtil.fromDartColor(Colors.black),
                ),
              ),
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                  ),
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.white),
                  ),
                ),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  desiredTickCount: 5,
                ),
                tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                  (num value) => '${value.toInt()}%',
                ),
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.white),
                  ),
                ),
              ),
              // defaultRenderer: new charts.BarRendererConfig(
              //   cornerStrategy: charts.ConstCornerStrategy(5),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  List<charts.Series<ContainerData, String>> _createSeriesData() {
    return [
      charts.Series<ContainerData, String>(
        id: 'Containers',
        domainFn: (ContainerData container, _) => container.ingredient,
        measureFn: (ContainerData container, _) => container.amount,
        colorFn: (ContainerData container, _) =>
            charts.ColorUtil.fromDartColor(container.color),
        data: this.data,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (ContainerData container, _) =>
            '${container.amount.toString()}%',
        // insideLabelStyleAccessorFn: (ContainerData container, _) =>
        //     charts.TextStyleSpec(
        //   color: charts.ColorUtil.fromDartColor(Colors.white),
        // ),
      )
    ];
  }
}

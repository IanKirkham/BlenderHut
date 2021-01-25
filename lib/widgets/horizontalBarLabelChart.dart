import 'package:blenderapp/apiService.dart';
import 'package:blenderapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:blenderapp/models/containerData.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

class HorizontalBarLabelChart extends StatefulWidget {
  final Function(BuildContext, ContainerData) onBarSelected;
  final String title;
  HorizontalBarLabelChart(this.onBarSelected, {this.title = "Containers"});

  @override
  _HorizontalBarLabelChartState createState() =>
      _HorizontalBarLabelChartState();
}

class _HorizontalBarLabelChartState extends State<HorizontalBarLabelChart> {
  Future<List<ContainerData>> _containerData;

  void refreshData() {
    setState(() {
      _containerData = _getContainerData();
    });
  }

  @override
  initState() {
    super.initState();
    _containerData = _getContainerData();
  }

  @override
  Widget build(BuildContext context) {
    //final List<charts.Series> seriesList = _createSeriesData();

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
            child: FutureBuilder(
              future: _containerData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData == null) {
                    return Center(
                        child: Text("An error occured loading the data",
                            style: TextStyle(color: Colors.red)));
                  } else {
                    return charts.BarChart(
                      _createSeriesData(snapshot.data),
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
                                // if (model.selectedSeries[0].measureFn(
                                //         model.selectedDatum[0].index) ==
                                //     0) {
                                //   final snackbar = SnackBar(
                                //     content: Text(
                                //         "Please add ingredient to canister first"),
                                //     backgroundColor: Colors.red,
                                //   );
                                //   Scaffold.of(context).showSnackBar(snackbar);
                                // } else {
                                ContainerData res = await widget.onBarSelected(
                                    context,
                                    snapshot
                                        .data[model.selectedDatum[0].index]);

                                refreshData();

                                // if (res != null) {
                                //   print(
                                //       "Modal sheet closed with value: ${res.percentFull}");
                                //   print(
                                //       "Modal sheet colsed with ingredient: ${res.ingredient.name}");
                                //   // setState(() {
                                //   //   //snapshot.data[
                                //   //   //  model.selectedDatum[0].index] = res;
                                //   //   refreshData();
                                //   // });
                                // } else {
                                //   setState(() {});
                                // }
                                //}
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
                      barRendererDecorator:
                          new charts.BarLabelDecorator<String>(
                        labelPosition: charts.BarLabelPosition.auto,
                        labelAnchor: charts.BarLabelAnchor.end,
                        insideLabelStyleSpec: charts.TextStyleSpec(
                          color: charts.ColorUtil.fromDartColor(Colors.black),
                        ),
                      ),
                      domainAxis: charts.OrdinalAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          lineStyle: charts.LineStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                          ),
                          labelStyle: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(Colors.white),
                          ),
                        ),
                      ),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        viewport: charts.NumericExtents(0, 100),
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
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<ContainerData>> _getContainerData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('user');
    User user = await getUser(userId);
    return user.containers.map((item) => ContainerData.fromJson(item)).toList();
  }

  List<charts.Series<ContainerData, String>> _createSeriesData(
      List<ContainerData> data) {
    return [
      charts.Series<ContainerData, String>(
        id: 'Containers',
        domainFn: (ContainerData container, _) => container.ingredient != null
            ? container.label + " - " + container.ingredient.name
            : container.label + " - Empty",
        measureFn: (ContainerData container, _) => container.percentFull,
        colorFn: (ContainerData container, _) => container.ingredient != null
            ? charts.ColorUtil.fromDartColor(
                Color(container.ingredient.colorValue))
            : charts.ColorUtil.fromDartColor(Colors.transparent),
        data: data,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (ContainerData container, _) =>
            '${container.percentFull.toString()}%',
        // insideLabelStyleAccessorFn: (ContainerData container, _) =>
        //     charts.TextStyleSpec(
        //   color: charts.ColorUtil.fromDartColor(Colors.white),
        // ),
      )
    ];
  }
}

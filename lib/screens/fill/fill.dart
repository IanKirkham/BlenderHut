import 'package:blenderapp/widgets/containerGraph.dart';
import 'package:blenderapp/widgets/horizontalBarLabelChart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Fill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //ContainerGraph(_sliderPopup),
          HorizontalBarLabelChart(_sliderPopup),
        ],
      ),
    );
  }
}

Future<int> _sliderPopup(context, ingredientData) async {
  int currentAmount = ingredientData.amount;

  int res = await showModalBottomSheet<int>(
    //barrierColor: Colors.transparent,
    backgroundColor: Color(0xFF2F3D46), //Colors.blueGrey[500],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Select amount for \n[ ${ingredientData.ingredient} ]",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return SfSliderTheme(
                  data: SfSliderThemeData(
                    activeTrackHeight: MediaQuery.of(context).size.height / 15,
                    inactiveTrackHeight:
                        MediaQuery.of(context).size.height / 15,
                    thumbRadius: 0.0,
                    trackCornerRadius: 7.0,
                    activeTickColor: Colors.white,
                    activeMinorTickColor: Colors.white,
                    activeLabelStyle:
                        TextStyle(color: Colors.white, fontSize: 14),
                    inactiveLabelStyle:
                        TextStyle(color: Colors.grey, fontSize: 14),
                    tickSize: Size(1.0, 12.0),
                    minorTickSize: Size(1.0, 8.0),
                  ),
                  child: SfSlider(
                    min: 0.0,
                    max: 100.0,
                    interval: 25,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 4,
                    // showDivisors: true,
                    showTicks: true,
                    labelFormatterCallback: (actualValue, formattedText) =>
                        actualValue.toInt().toString() + "%",
                    tooltipTextFormatterCallback:
                        (actualValue, formattedText) =>
                            actualValue.toInt().toString() + "%",
                    stepSize: 5.0,
                    activeColor: ingredientData.color,
                    inactiveColor: ingredientData.color.withOpacity(0.2),
                    value: currentAmount.toDouble(),
                    // numberFormat: NumberFormat.percentPattern(),
                    onChanged: (newAmount) {
                      setState(() => {currentAmount = newAmount.toInt()});
                    },
                  ),
                );
              },
            ),
            MaterialButton(
              onPressed: () {
                // save to the database somehow?
                //print("amount was ${ingredientData.amount}");
                Navigator.pop(context, currentAmount);
              },
              minWidth: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 17,
              color: Color(0xFF48C28C), //Colors.green,
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
  return res;
}

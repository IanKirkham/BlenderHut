import 'package:blenderapp/widgets/canisterGraph.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Fill extends StatefulWidget {
  @override
  _FillState createState() => _FillState();
}

class _FillState extends State<Fill> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CanisterGraph(this._sliderPopup),
        ],
      ),
    );
  }

  Future<int> _sliderPopup(context, ingredientData) async {
    int currentAmount = ingredientData.amount;

    int res = await showModalBottomSheet<int>(
      //barrierColor: Colors.transparent,
      backgroundColor: Colors.blueGrey[500],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.45,
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
                  // return Slider(
                  //   min: 0,
                  //   max: 100,
                  //   divisions: 20,
                  //   label: currentAmount.toString() + "%",
                  //   value: currentAmount.toDouble(),
                  //   activeColor: ingredientData.color,
                  //   onChanged: (newAmount) {
                  //     setState(() => {currentAmount = newAmount.toInt()});
                  //   },
                  // );
                  return SfSliderTheme(
                    data: SfSliderThemeData(
                      activeTrackHeight:
                          MediaQuery.of(context).size.height / 15,
                      inactiveTrackHeight:
                          MediaQuery.of(context).size.height / 15,
                      thumbRadius: 0.0,
                      trackCornerRadius: 7.0,
                    ),
                    child: SfSlider(
                      min: 0.0,
                      max: 100.0,
                      interval: 25,
                      showLabels: true,
                      enableTooltip: true,
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
                minWidth: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 15,
                color: Colors.green,
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
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
}

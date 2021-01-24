import 'package:blenderapp/models/containerData.dart';
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
          HorizontalBarLabelChart(_sliderPopup, title: "Fill Containers"),
        ],
      ),
    );
  }
}

Future<ContainerData> _sliderPopup(context, ContainerData container) async {
  int currentAmount = container.percentFull;

  ContainerData res = await showModalBottomSheet<ContainerData>(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Select amount for \n[ ${container.ingredient.name} ]",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
              color: Colors.purple,
              child: Center(
                child: Icon(
                  IconData(container.ingredient.iconCode,
                      fontFamily: 'CustomIcons'),
                  color: Colors.white,
                  size: 50,
                ),
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
                    activeColor: Color(container.ingredient.colorValue),
                    inactiveColor:
                        Color(container.ingredient.colorValue).withOpacity(0.2),
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
                // save to database,
                // return ContainerData object

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

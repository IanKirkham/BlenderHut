import 'package:blenderapp/widgets/canisterGraph.dart';
import 'package:flutter/material.dart';

class Fill extends StatefulWidget {
  @override
  _FillState createState() => _FillState();
}

class _FillState extends State<Fill> {
  double _amount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CanisterGraph(this._sliderPopup),
      ],
    );
  }

  void _sliderPopup(context, amount) {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Select amount",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  )),
              StatefulBuilder(
                builder: (context, setState) {
                  return Slider(
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: amount.toStringAsFixed(0) + "%",
                    value: amount,
                    onChanged: (newAmount) {
                      setState(() => {amount = newAmount});
                    },
                  );
                },
              ),
              MaterialButton(
                onPressed: () {
                  // save to the database somehow?
                  Navigator.pop(context);
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
  }
}

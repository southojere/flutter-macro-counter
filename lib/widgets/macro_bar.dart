import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MacroBar extends StatelessWidget {
  final String label;
  final double value;
  final double goalValue;

  MacroBar(this.label, this.value, this.goalValue);

  @override
  Widget build(BuildContext context) {

    double percentage = this.value/this.goalValue;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Text(this.label),
        new LinearPercentIndicator(
                lineHeight: 17.0,
                percent: percentage < 1.0 ? percentage : 1,
                backgroundColor: Colors.grey,
                center: Text(this.value.toString(), style: TextStyle(
                  fontSize: 14
                )),
                progressColor: Theme.of(context).primaryColor,
              ),
      ]),
    );
  }
}

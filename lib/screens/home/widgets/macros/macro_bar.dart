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
    double percentage = this.value / this.goalValue;
    double remaining = goalValue - value;
    String displayValue = '${remaining.toString()} left';
    if (remaining < 0) displayValue = 'Done!';

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(this.label), Text("${displayValue}")],
              ),
            ),
            new LinearPercentIndicator(
              lineHeight: 7.0,
              percent: percentage < 1.0 ? percentage : 1,
              backgroundColor: Colors.grey,
              progressColor: Theme.of(context).primaryColor,
            ),
          ]),
    );
  }
}

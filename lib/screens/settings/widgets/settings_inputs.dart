import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/shared/custom_toast.dart/index.dart';
import 'package:provider/provider.dart';
import 'package:macro_counter_app/models/User.dart';

class SettingsInput extends StatefulWidget {
  final double carbsTarget;
  final double proteinTarget;
  final double fatTarget;
  final Function updateTargets;
  SettingsInput({
    @required this.carbsTarget,
    @required this.proteinTarget,
    @required this.fatTarget,
    @required this.updateTargets,
  });

  @override
  State<StatefulWidget> createState() {
    return _SettingsInputState();
  }
}

class _SettingsInputState extends State<SettingsInput> {
  double carbs = 0;
  double protein = 0;
  double fat = 0;

  void handleTargetSave(User user) {
  widget.updateTargets(carbs.roundToDouble(), protein.roundToDouble(),
                fat.roundToDouble(), user);
    ToastUtils.showCustomToast(context, "Saved Targets",
        Icon(Icons.done_all, color: Colors.white), ToastType.complete);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      carbs = widget.carbsTarget;
      protein = widget.proteinTarget;
      fat = widget.fatTarget;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Column buildInputRow(double value, String inputLabel, Function setValue) {
      int formattedValue = value.toInt();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${inputLabel} ${formattedValue}'),
          Slider(
            value: value,
            onChanged: (value) {
              setValue(value);
            },
            min: 0,
            max: 500,
          )
        ],
      );
    }

    Padding buildSaveBtn(BuildContext context, User user) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).textTheme.button.color,
          onPressed: () => handleTargetSave(user),
          child: Text('Save'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildInputRow(carbs, "Target Carbs:", (value) {
          setState(() => carbs = value);
        }),
        buildInputRow(protein, "Target Protein:", (value) {
          setState(() => protein = value);
        }),
        buildInputRow(fat, "Target Fat:", (value) {
          setState(() => fat = value);
        }),
        buildSaveBtn(context, user),
      ],
    );
  }
}

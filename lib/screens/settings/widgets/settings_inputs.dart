import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final _formKey = GlobalKey<FormState>();

  final _carbsController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Row buildInputRow(
        double value, String inputLabel, TextEditingController controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${value}'),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: inputLabel,
              ),
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value == '') return 'Field is required';
                return null;
              },
            ),
          width: MediaQuery.of(context).size.width * 0.8,),
        ],
      );
    }

    Padding buildSaveBtn(BuildContext context, User user) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).textTheme.button.color,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              // save settings
              double carbs = double.parse(_carbsController.text);
              double protein = double.parse(_proteinController.text);
              double fat = double.parse(_fatController.text);
              widget.updateTargets(carbs, protein, fat, user);
            }
          },
          child: Text('Save'),
        ),
      );
    }

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildInputRow(widget.carbsTarget, "Target Carbs", _carbsController),
            buildInputRow(
                widget.proteinTarget, "Target Protein", _proteinController),
            buildInputRow(widget.fatTarget, "Target Fat", _fatController),
            buildSaveBtn(context, user),
          ],
        ));
  }
}

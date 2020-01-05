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

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _carbsController,
              decoration: InputDecoration(
                  labelText: 'Target Carbs',
                  hintText: 'Current protein target: ${widget.carbsTarget}'),
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value == '') return 'Field is required';
                return null;
              },
            ),
            TextFormField(
              controller: _proteinController,
              decoration: InputDecoration(
                  labelText: 'Target Protein',
                  hintText: 'Current protein target: ${widget.proteinTarget}'),
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value == '') return 'Field is required';
                return null;
              },
            ),
            TextFormField(
              controller: _fatController,
              decoration: InputDecoration(
                  labelText: 'Target Fat',
                  hintText: 'Current fat target: ${widget.fatTarget}'),
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value == '') return 'Field is required';
                return null;
              },
            ),
            Padding(
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
            ),
          ],
        ));
  }
}

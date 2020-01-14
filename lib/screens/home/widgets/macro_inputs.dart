import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:provider/provider.dart';
import 'package:macro_counter_app/models/User.dart';
import 'package:macro_counter_app/models/UserFirestoreData.dart';

class MacroInputs extends StatefulWidget {
  final Function addMacros;
  final Function addFood;
  MacroInputs({
    @required this.addMacros,
    @required this.addFood,
  });

  @override
  State<StatefulWidget> createState() {
    return new _MacroInputState();
  }
}

class _MacroInputState extends State<MacroInputs> {
  final _nameController = TextEditingController();
  final _carbsController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();

  _onSubmit(User user) {
    double carbs = double.parse(
        _carbsController.text == '' ? '0.0' : _carbsController.text);
    double protein = double.parse(
        _proteinController.text == '' ? '0.0' : _proteinController.text);
    double fat =
        double.parse(_fatController.text == '' ? '0.0' : _fatController.text);

    widget.addMacros(carbs, protein, fat, user);

    _carbsController.clear();
    _proteinController.clear();
    _fatController.clear();
  }

  _onSaveFood(User currentUser) {
    String name = _nameController.text;
    if (name == '') {
      return;
    }
    double carbs = double.parse(
        _carbsController.text == '' ? '0.0' : _carbsController.text);
    double protein = double.parse(
        _proteinController.text == '' ? '0.0' : _proteinController.text);
    double fat =
        double.parse(_fatController.text == '' ? '0.0' : _fatController.text);

    Food newFood =
        new Food(name: name, carbs: carbs, protein: protein, fat: fat);
    widget.addFood(newFood, currentUser);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // final userAppData = Provider.of<UserData>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name (optional)'),
            keyboardType: TextInputType.text,
          ),
          TextField(
            controller: _carbsController,
            decoration: InputDecoration(labelText: 'Carbs'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _proteinController,
            decoration: InputDecoration(labelText: 'Protein'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _fatController,
            decoration: InputDecoration(labelText: 'Fat'),
            keyboardType: TextInputType.number,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                tooltip: 'Save this entry to your library',
                onPressed: () => _onSaveFood(user),
                color: Theme.of(context).primaryColor,
              ),
              RaisedButton(
                child: Text('Add Macros'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => _onSubmit(user),
              ),
            ],
          )
        ],
      ),
    );
  }
}

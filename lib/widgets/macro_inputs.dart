import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro_counter_app/models/Food.dart';

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

  _onSubmit() {
    double carbs = double.parse(
        _carbsController.text == '' ? '0.0' : _carbsController.text);
    double protein = double.parse(
        _proteinController.text == '' ? '0.0' : _proteinController.text);
    double fat =
        double.parse(_fatController.text == '' ? '0.0' : _fatController.text);

    widget.addMacros(carbs, protein, fat);

    _carbsController.clear();
    _proteinController.clear();
    _fatController.clear();
  }

  _onSaveFood() {
    print('on save');
    String name = _nameController.text;
    if(name == '') {
      return;
    }
    double carbs = double.parse(
        _carbsController.text == '' ? '0.0' : _carbsController.text);
    double protein = double.parse(
        _proteinController.text == '' ? '0.0' : _proteinController.text);
    double fat =
        double.parse(_fatController.text == '' ? '0.0' : _fatController.text);

    Food newFood = new Food(name: name, carbs: carbs, protein: protein, fat: fat);
    widget.addFood(newFood);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name (optional)'),
            keyboardType: TextInputType.text,
            onSubmitted: (_) => _onSubmit(),
          ),
          TextField(
            controller: _carbsController,
            decoration: InputDecoration(labelText: 'Carbs'),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _onSubmit(),
          ),
          TextField(
            controller: _proteinController,
            decoration: InputDecoration(labelText: 'Protein'),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _onSubmit(),
          ),
          TextField(
            controller: _fatController,
            decoration: InputDecoration(labelText: 'Fat'),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _onSubmit(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                tooltip: 'Save this entry to your library',
                onPressed: () =>  _onSaveFood(),
                color: Theme.of(context).primaryColor,
              ),
              RaisedButton(
                child: Text('Add Macros'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _onSubmit,
              ),
            ],
          )
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:macro_counter_app/shared/custom_toast.dart/index.dart';
import 'package:provider/provider.dart';
import 'package:macro_counter_app/models/User.dart';

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

  _onSubmit(User user, BuildContext context) {
    double carbs = double.parse(
        _carbsController.text == '' ? '0.0' : _carbsController.text);
    double protein = double.parse(
        _proteinController.text == '' ? '0.0' : _proteinController.text);
    double fat =
        double.parse(_fatController.text == '' ? '0.0' : _fatController.text);

    widget.addMacros(
        new Food(name: "", carbs: carbs, protein: protein, fat: fat), user);

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

    // display toast
    ToastUtils.showCustomToast(context, "Added Food",
        Icon(Icons.done_all, color: Colors.white), ToastType.complete);
  }

  Padding buildTextInput(
      TextEditingController controller, String label, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: TextField(
        controller: controller,
        style: new TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
            labelText: label,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark, width: 1.0))),
        keyboardType: inputType,
      ),
    );
  }

  RaisedButton buildButton(
      String label, Function onPress, BuildContext context) {
    return RaisedButton(
      child: Text(label),
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).textTheme.button.color,
      onPressed: onPress,
    );
  }

  Column buildSheetItems(User user, BuildContext context) {
    return Column(
      children: <Widget>[
        buildTextInput(_nameController, 'Name (optional)', TextInputType.text),
        Row(
          children: <Widget>[
            Flexible(
                child: buildTextInput(
                    _carbsController, 'Carbs', TextInputType.number)),
            Flexible(
              child: buildTextInput(
                  _proteinController, 'Protein', TextInputType.number),
            ),
            Flexible(
                child: buildTextInput(
                    _fatController, 'Fat', TextInputType.number)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buildButton('Save', () => _onSaveFood(user), context),
              SizedBox(
                width: 10,
              ),
              buildButton('Quick Add', () => _onSubmit(user, context), context),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // final userAppData = Provider.of<UserData>(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: buildSheetItems(user, context),
      ),
    );
  }
}

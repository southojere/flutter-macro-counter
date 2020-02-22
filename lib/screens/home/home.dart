import 'package:flutter/material.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:macro_counter_app/models/Macro.dart';
import 'package:macro_counter_app/screens/home/widgets/food_list.dart';
import 'package:macro_counter_app/screens/home/widgets/macro_inputs.dart';
import 'package:macro_counter_app/screens/home/widgets/macros/macros.dart';
import 'package:macro_counter_app/screens/settings/settings_screen.dart';
import 'package:macro_counter_app/services/auth.dart';
import 'package:macro_counter_app/services/database.dart';
import 'package:macro_counter_app/models/User.dart';
import 'package:macro_counter_app/shared/custom_toast.dart/index.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Macro> macros = [
    new Macro(label: 'Carbohydrates', value: 0, goalValue: 365),
    new Macro(label: 'Protein', value: 0, goalValue: 120),
    new Macro(label: 'Fats', value: 0, goalValue: 60)
  ];

  dynamic userInfo;
  List<Food> foodList;

  @override
  void initState() {
    super.initState();
    AuthService().getUser().then((user) {
      DatabaseService(uid: user.uid).getUserData().then((userObj) {
        setState(() {
          foodList = userObj.foods;
          macros = [
            new Macro(
                label: 'carbs',
                value: userObj.currentCarbs,
                goalValue: userObj.targetCarbs),
            new Macro(
                label: 'protein',
                value: userObj.currentProtein,
                goalValue: userObj.targetProtein),
            new Macro(
                label: 'fat',
                value: userObj.currentFat,
                goalValue: userObj.targetFat),
          ];
        });
      });
    });
  }

  void addMacros(Food foodToAdd, User user) {
    setState(() {
      macros[0].value += foodToAdd.carbs;
      macros[1].value += foodToAdd.protein;
      macros[2].value += foodToAdd.fat;
    });
    DatabaseService(uid: user.uid).addNewMacros(
        carbs: foodToAdd.carbs, protein: foodToAdd.protein, fat: foodToAdd.fat);
  }

  void resetMacros(User user) {
    setState(() {
      macros[0].value = 0;
      macros[1].value = 0;
      macros[2].value = 0;
    });
    DatabaseService(uid: user.uid).resetMacros();
  }

  void deleteFood(Food foodToRemove, User user) {
    print(foodToRemove.id);
    setState(() {
      foodList.removeWhere((food) {
        if (food.id == foodToRemove.id) {
          return true;
        }
        return false;
      });
    });
    DatabaseService(uid: user.uid).removeFoodFromList(foodToRemove);
    ToastUtils.showCustomToast(context, "Deleted",
        Icon(Icons.delete, color: Colors.white), ToastType.error);
  }

  void addFood(Food newFoodEntry, User user) {
    setState(() {
      foodList.add(newFoodEntry);
    });
    DatabaseService(uid: user.uid).addFoodToList(newFoodEntry);
  }

  void _startAddMacros(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (ctx) {
          return MacroInputs(
            addMacros: addMacros,
            addFood: addFood,
          );
        });
  }

  void updateTargets(newCarbTarget, newProteinTarget, newFatTarget, User user) {
    setState(() {
      macros[0].goalValue = newCarbTarget;
      macros[1].goalValue = newProteinTarget;
      macros[2].goalValue = newFatTarget;
    });

    DatabaseService(uid: user.uid).updateTargets(
        carbs: newCarbTarget, protein: newProteinTarget, fat: newFatTarget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add), onPressed: () => _startAddMacros(context)),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                          macros: macros,
                          updateTargets: updateTargets,
                        )),
              );
            },
          )
        ],
        title: Text('Dashboard'),
      ),
      body: Column(
        children: <Widget>[
          Macros(macros, resetMacros),
          FoodList(foodList, deleteFood, addMacros)
        ],
      ),
    );
  }
}

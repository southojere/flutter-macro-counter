import 'package:flutter/material.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:macro_counter_app/models/Macro.dart';
import 'package:macro_counter_app/models/UserFirestoreData.dart';
import 'package:macro_counter_app/screens/home/widgets/food_list.dart';
import 'package:macro_counter_app/screens/home/widgets/macro_inputs.dart';
import 'package:macro_counter_app/screens/home/widgets/macros/macros.dart';
import 'package:macro_counter_app/screens/settings/settings_screen.dart';
import 'package:macro_counter_app/services/auth.dart';
import 'package:macro_counter_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:macro_counter_app/models/User.dart';

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
        });
      });
    });
  }

  void quickAddMacros(Food foodToAdd, User user) {
    setState(() {
      macros[0].value += foodToAdd.carbs;
      macros[1].value += foodToAdd.protein;
      macros[2].value += foodToAdd.fat;
    });
    DatabaseService(uid: user.uid).addNewMacros(
        carbs: foodToAdd.carbs, protein: foodToAdd.protein, fat: foodToAdd.fat);
  }

  void addMacros(double carb, double protein, double fat, User user) {
    setState(() {
      macros[0].value += carb;
      macros[1].value += protein;
      macros[2].value += fat;
    });
    DatabaseService(uid: user.uid)
        .addNewMacros(carbs: carb, protein: protein, fat: fat);
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
    final user = Provider.of<User>(context);

    // TODO: remove stream and just use local
    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddMacros(context)),
            IconButton(
              icon: Icon(Icons.settings),
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
            Macros(macros),
            FoodList(foodList, deleteFood, quickAddMacros)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddMacros(context),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:macro_counter_app/models/Macro.dart';
import 'package:macro_counter_app/widgets/food_list.dart';
import 'package:macro_counter_app/widgets/macro_inputs.dart';
import 'package:macro_counter_app/widgets/macros.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: Colors.orange,
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
              ),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // TODO: set from database
  List<Macro> macros = [
    new Macro(label: 'Carbohydrates', value: 78, goalValue: 360),
    new Macro(label: 'Protein', value: 43, goalValue: 120),
    new Macro(label: 'Fats', value: 10, goalValue: 60)
  ];

  List<Food> foodLibrary = [];


  void quickAddMacros (Food foodToAdd) {
     setState(() {
      macros[0].value += foodToAdd.carbs;
      macros[1].value += foodToAdd.protein;
      macros[2].value += foodToAdd.fat;
    });
  }

  void addMacros(double carb, double protein, double fat) {
    setState(() {
      macros[0].value += carb;
      macros[1].value += protein;
      macros[2].value += fat;
    });
  }

  void deleteFood(Food foodToRemove) {
    setState(() {
      foodLibrary.removeWhere((food) {
        if (food.id == foodToRemove.id) return true;
        return false;
      });
    });
  }

  void addFood(Food newFoodEntry) {
    setState(() {
      foodLibrary.add(newFoodEntry);
    });
    print(foodLibrary.length);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add), onPressed: () => _startAddMacros(context))
        ],
        title: Text('Dashboard'),
      ),
      body: Column(
        children: <Widget>[Macros(macros), FoodList(foodLibrary, deleteFood,quickAddMacros)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddMacros(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:macro_counter_app/models/User.dart';
import 'package:macro_counter_app/models/UserFirestoreData.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodList extends StatelessWidget {
  final List<Food> food;
  final Function deleteFood;
  final Function addFood;
  FoodList(this.food, this.deleteFood, this.addFood);

  @override
  Widget build(BuildContext context) {

    final userAppData = Provider.of<UserData>(context);

    return Flexible(
      child: new ListView.builder(
        itemCount: userAppData != null ? userAppData.foods.length : 0,
        itemBuilder: (BuildContext ctx, int index) {
          final Food foodItem = userAppData.foods[index];
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Title
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    foodItem.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Macro details
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("${foodItem.carbs}C"),
                        SizedBox(
                          width: 10,
                        ),
                        Text("${foodItem.protein}P"),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${foodItem.fat}F'),
                        SizedBox(
                          width: 10,
                        ),
                        //Add quick add button
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            this.addFood(foodItem);
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            this.deleteFood(foodItem);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

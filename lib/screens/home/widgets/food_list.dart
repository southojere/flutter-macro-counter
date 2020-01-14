import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:macro_counter_app/models/User.dart';
import 'package:macro_counter_app/models/UserFirestoreData.dart';
import 'package:macro_counter_app/shared/loading.dart';
import 'package:provider/provider.dart';

class FoodList extends StatefulWidget {
  final Function deleteFood;
  final Function addFood;
  final List<Food> foodList;
  FoodList(this.foodList,this.deleteFood, this.addFood);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final userAppData = Provider.of<UserData>(context);

    Flexible buildFoodTitle(Food foodItem, BuildContext context) {
      return Flexible(
        child: Container(
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
      );
    }

    Card buildFoodCard(Food foodItem, BuildContext context, User user) {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Title
            buildFoodTitle(foodItem, context),
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
                        this.widget.addFood(foodItem, user);
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        this.widget.deleteFood(foodItem, user);
                      },
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }

    if(widget.foodList == null) {
      return Loading();
    }

    return Flexible(
      child: new ListView.builder(
        itemCount:  widget.foodList.length,
        itemBuilder: (BuildContext ctx, int index) {
          final Food foodItem = widget.foodList[index];
      
          return buildFoodCard(foodItem, context, user);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:macro_counter_app/models/User.dart';
import 'package:macro_counter_app/models/UserFirestoreData.dart';
import 'package:macro_counter_app/shared/custom_toast.dart/index.dart';
import 'package:macro_counter_app/shared/dialog.dart';
import 'package:macro_counter_app/shared/loading.dart';
import 'package:provider/provider.dart';

class FoodList extends StatefulWidget {
  final Function deleteFood;
  final Function addFood;
  final List<Food> foodList;
  FoodList(this.foodList, this.deleteFood, this.addFood);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Flexible buildFoodTitle(Food foodItem, BuildContext context) {
      return Flexible(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      foodItem.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
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
                  ],
                )
              ],
            )),
      );
    }

    Widget slideRightBackground() {
      return Container(
        color: Colors.green,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
              Text(
                " Edit",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      );
    }

    Widget slideLeftBackground() {
      return Container(
        color: Colors.red,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              Text(
                " Delete",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Add quick add button
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    this.widget.addFood(foodItem, user);
                    ToastUtils.showCustomToast(
                        context,
                        "Added ${foodItem.name}",
                        Icon(Icons.done_all, color: Colors.white),
                        ToastType.complete);
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ],
            )
          ],
        ),
      );
    }

    if (widget.foodList == null) {
      return Loading();
    }

    return Flexible(
      child: new ListView.builder(
        itemCount: widget.foodList.length,
        itemBuilder: (BuildContext ctx, int index) {
          final Food foodItem = widget.foodList[index];

          return Dismissible(
              key: Key(foodItem.id),
              background: slideRightBackground(),
              secondaryBackground: slideLeftBackground(),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  final action = await Dialogs.yesAbortDialog(context, "Remove",
                      "Are you sure you want to remove ${foodItem.name} from your list?");
                  if (action == DialogAction.yes) {
                    setState(() {
                      widget.foodList.removeAt(index);
                      this.widget.deleteFood(foodItem, user);
                    });
                    return true;
                  } else {
                    return false;
                  }
                }
                return false;
              },
              child: buildFoodCard(foodItem, context, user));
        },
      ),
    );
  }
}

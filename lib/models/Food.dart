import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Food {
  String name;
  double carbs;
  double protein;
  double fat;
  String id;

  Food(
      {@required this.name,
      @required this.carbs,
      @required this.protein,
      @required this.fat}) {
        this.id = Uuid().v1();
      }
}

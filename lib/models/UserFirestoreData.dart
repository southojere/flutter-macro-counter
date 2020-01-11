import 'package:macro_counter_app/models/Food.dart';

class UserData {
  final dynamic currentCarbs;
  final dynamic currentProtein;
  final dynamic currentFat;

  final dynamic targetCarbs;
  final dynamic targetProtein;
  final dynamic targetFat;

  List foods = [];

  UserData(
      {this.currentCarbs,
      this.currentProtein,
      this.currentFat,
      this.foods,
      this.targetCarbs,
      this.targetProtein,
      this.targetFat});


      setFoods(List foods) {
        this.foods = foods;
      }
}

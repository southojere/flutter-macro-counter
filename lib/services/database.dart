import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:macro_counter_app/models/Food.dart';
import 'package:macro_counter_app/models/UserFirestoreData.dart';

class DatabaseService {
  final uid;
  DatabaseService({@required this.uid});

  // collection ref
  final CollectionReference userDataCollection =
      Firestore.instance.collection('user-data');

  Future updateUserData(
      {double targetCarbs, double targetProtein, double targetFat}) async {
    return await userDataCollection.document(uid).setData({
      'currentCarbs': 0.0,
      'currentProtein': 0.0,
      'currentFat': 0.0,
      'targetCarbs': targetCarbs,
      'targetProtein': targetProtein,
      'targetFat': targetFat,
    });
  }

  // transform to food object
  List<Food> _foodsToObject(List foods) {
    return foods.map((food) {
      return new Food(
        carbs: (food['carbs'] ?? 0).toDouble(),
        protein: (food['protein'] ?? 0).toDouble(),
        fat: (food['fat'] ?? 0).toDouble(),
        id: food['id'],
        name: food['name'],
      );
    }).toList();
  }

  // userdata from snapshot
  UserData _usersFromSnapshot(DocumentSnapshot doc) {
    
    return UserData(
      targetCarbs: doc.data['targetCarbs'] ?? 0.0,
      targetProtein: doc.data['targetProtein'] ?? 0.0,
      targetFat: doc.data['targetFat'] ?? 0.0,
      currentCarbs: doc.data['currentCarbs'] ?? 0.0,
      currentProtein: doc.data['currentProtein'] ?? 0.0,
      currentFat: doc.data['currentFat'] ?? 0.0,
    );
  }

  Future<UserData> getUserData () {
    return userDataCollection.document("${uid}").get().then((doc) {
      var userDetails = _usersFromSnapshot(doc);
      return userDetails;
    }).then((UserData user) async {
      List usersFoods = await userDataCollection
          .document("${uid}")
          .collection('foods')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        return _foodsToObject(snapshot.documents);
      });

      user.setFoods(usersFoods);
      return user;
    });
  }

  Stream<UserData> get userData {
    return userDataCollection.document("${uid}").get().then((doc) {
      var userDetails = _usersFromSnapshot(doc);
      return userDetails;
    }).then((UserData user) async {
      List usersFoods = await userDataCollection
          .document("${uid}")
          .collection('foods')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        return _foodsToObject(snapshot.documents);
      });

      user.setFoods(usersFoods);
      return user;
    }).asStream();
  }

  // adds new food item to this users food library
  void addFoodToList(Food newFood) {
    userDataCollection.document("${uid}").collection('foods').add({
      "name": newFood.name,
      "carbs": newFood.carbs,
      "protein": newFood.protein,
      "fat": newFood.fat,
      "id": newFood.id
    });
  }

  // remove food from food list
  void removeFoodFromList(Food foodToRemove) async {
    QuerySnapshot foodDocsToRemove = await userDataCollection
        .document("${uid}")
        .collection('foods')
        .where('id', isEqualTo: foodToRemove.id)
        .getDocuments();
    await Future.wait(foodDocsToRemove.documents.map((foodDoc) {
      return foodDoc.reference.delete();
    }));
  }

  // update current carbs for this user
  void _addCarbs(double carbs) {
    userDataCollection.document("${uid}").updateData({
      "currentCarbs": FieldValue.increment(carbs),
    });
  }

  void _addProtein(double protein) {
    userDataCollection.document("${uid}").updateData({
      "currentProtein": FieldValue.increment(protein),
    });
  }

  void _addFat(double fat) {
    userDataCollection.document("${uid}").updateData({
      "currentFat": FieldValue.increment(fat),
    });
  }

  void addNewMacros({double carbs, double protein, double fat}) {
    _addCarbs(carbs);
    _addProtein(protein);
    _addFat(fat);
  }

  // resets the current macros
  void resetMacros() {
    userDataCollection.document("${uid}").updateData({
      "currentProtein": 0.0,
      "currentCarbs": 0.0,
      "currentFat": 0.0,
    });
  }

  // update users target macros
  void updateTargets({double carbs, double protein, double fat}) {
    userDataCollection.document("${uid}").updateData({
      "targetCarbs": carbs,
      "targetProtein": protein,
      "targetFat": fat,
    });
  }
}

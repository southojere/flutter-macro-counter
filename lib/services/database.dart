import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // collection ref
  final CollectionReference savedFoodsCollection = Firestore.instance.collection('foods');
}
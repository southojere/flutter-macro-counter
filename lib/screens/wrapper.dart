
import 'package:flutter/cupertino.dart';
import 'package:macro_counter_app/screens/auth/auth.dart';
import 'package:macro_counter_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // either return auth screen or home
    return MyHomePage();
  }
}
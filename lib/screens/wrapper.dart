
import 'package:flutter/cupertino.dart';
import 'package:macro_counter_app/screens/auth/auth.dart';
import 'package:macro_counter_app/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:macro_counter_app/models/User.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context,) {
    final user = Provider.of<User>(context);

    if(user == null) return Auth();
    else return MyHomePage(); // have a logined in user
  }
}
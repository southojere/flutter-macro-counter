import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:macro_counter_app/models/User.dart';
class UserDetail extends StatelessWidget{

  UserDetail();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('id: ${user.uid}'),
        Text('username: ${user.email}'),
        SizedBox(height: 20,)
      ],
    );
  }
}
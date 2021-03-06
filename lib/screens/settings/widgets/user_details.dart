import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:macro_counter_app/models/User.dart';

class UserDetail extends StatelessWidget {
  UserDetail();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SizedBox(
       width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left:17.0),
            child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Text('Id: ${user.uid}'),
            Text('Username: ${user.email}'),
            SizedBox(
              height: 20,
            )
        ],
      ),
          ),
    );
  }
}

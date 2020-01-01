import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/screens/auth/register.dart';
import 'package:macro_counter_app/screens/auth/sign_in.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = false;

  void toggleView () {
    setState(() => showSignIn = !showSignIn,);
  }


  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(
        child: SignIn(toggleView),
      );
    } else {
      return Container(
        child: Register(toggleView),
      );
    }
  }
}

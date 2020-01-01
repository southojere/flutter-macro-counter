
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          
        ],
        title: Text('Login'),
      ),
      body: Text('auth page')
    );
  }
}
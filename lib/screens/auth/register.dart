import 'package:flutter/material.dart';
import 'package:macro_counter_app/screens/auth/sign_in.dart';
import 'package:macro_counter_app/services/auth.dart';
import 'package:macro_counter_app/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register(this.toggleView);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

   String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Login'),
              onPressed: () {
                widget.toggleView();
              },
            )
          ],
          title: Text('Sign up'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                   decoration: textInputDeco(context).copyWith(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) return 'Field is required';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: textInputDeco(context).copyWith(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) return 'Field is required';
                      if(value.length < 6) return 'Enter a password 6+ chars';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(_passwordController.text);
                        print(_emailController.text);
                        dynamic res = await _auth.registerWithEmailAndPassword(_emailController.text, _passwordController.text);
                        if(res == null) {
                          setState(() {
                            error = 'Error occured on signup';
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(error != null ? error : '', style: TextStyle(color: Colors.red),)

                ],
              ),
            )));
  }
}

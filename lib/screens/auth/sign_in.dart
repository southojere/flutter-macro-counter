import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/screens/auth/register.dart';
import 'package:macro_counter_app/services/auth.dart';
import 'package:macro_counter_app/shared/constants.dart';
import 'package:macro_counter_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loading = false;

  String error;

  @override
  Widget build(BuildContext context) {


    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: () {
                widget.toggleView();
              },
            )
          ],
          title: Text('Login'),
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
                      if (value.length < 6) return 'Enter a password 6+ chars';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        print(_passwordController.text);
                        print(_emailController.text);
                        dynamic res = await _auth.signInWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                        if (res == null) {
                          setState(() {
                            error = 'Could not signin with those credential';
                            loading = false;
                          });
                        }
                         setState(() {
                          loading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    error != null ? error : '',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            )));
  }
}

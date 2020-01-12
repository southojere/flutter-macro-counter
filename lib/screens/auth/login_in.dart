import 'package:flutter/material.dart';
import 'package:macro_counter_app/services/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage(this.toggleView);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loading = false;
  String error;
  Container buildTitle(ThemeData theme) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      alignment: Alignment.bottomCenter,
      height: 60.0,
      child: Text(
        'Login',
        style: TextStyle(fontSize: 18.0, color: theme.secondaryHeaderColor),
      ),
    );
  }

  SizedBox buildFacebookButton() {
    return SizedBox(
      width: 250.0,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Color(0xFF486198),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              MdiIcons.facebook,
              size: 16.0,
              color: Colors.white,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              'Login with facebook',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Padding buildText(ThemeData theme, String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: theme.primaryColorDark, fontSize: fontSize),
      ),
    );
  }

  Padding buildEmailPasswordInputField(
      String labelText, String hintText, bool isObscure, ThemeData theme) {
    Function emailValidation = (value) {
      if (value.isEmpty) return 'Field is required';
      return null;
    };

    Function passwordValidation = (value) {
      if (value.isEmpty) return 'Field is required';
      if (value.length < 6) return 'Enter a password 6+ chars';
      return null;
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        style: new TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(color: theme.primaryColorDark),
          hintStyle: TextStyle(color: theme.primaryColorDark),
        ),
        obscureText: isObscure,
        controller:
            labelText == 'password' ? _passwordController : _emailController,
        validator: labelText == 'email'
            ? emailValidation
            : labelText == 'password' ? passwordValidation : null,
        keyboardType: labelText == 'email' ? TextInputType.emailAddress : null,
      ),
    );
  }

  SizedBox buildLoginBtn(ThemeData theme) {
    return SizedBox(
      width: 250.0,
      child: RaisedButton(
        color: theme.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() => loading = true);
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
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, kToolbarHeight, 16.0, 16.0),
        children: <Widget>[
          Align(
            child: SizedBox(
              width: 320.0,
              child: Card(
                color: Color(0xFF314055),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      buildTitle(theme),
                      buildFacebookButton(),
                      buildText(theme, 'or', 12.0),
                      buildText(theme, 'Login with your email address', 12.0),
                      buildEmailPasswordInputField(
                          'email', 'your@email.com', false, theme),
                      buildEmailPasswordInputField('password', '', true, theme),
                      SizedBox(
                        height: 18.0,
                      ),
                      buildLoginBtn(theme),
                      Text(
                        error != null ? error : '',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

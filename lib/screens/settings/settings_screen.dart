

import 'package:flutter/material.dart';
import 'package:macro_counter_app/models/Macro.dart';
import 'package:macro_counter_app/services/auth.dart';
import 'package:macro_counter_app/widgets/settings_inputs.dart';

class SettingsScreen extends StatefulWidget {

  final List<Macro> macros;
  final Function updateTargets;
  SettingsScreen({this.macros, this.updateTargets});

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {

  final AuthService _auth =  AuthService();

  @override
  Widget build(BuildContext context) {
    
    double carbsTarget = widget.macros != null ? widget.macros[0].goalValue : 0;
    double proteinTarget = widget.macros != null ? widget.macros[1].goalValue: 0;
    double fatTarget = widget.macros != null ? widget.macros[2].goalValue : 0;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pop();
            },
          )
        ],
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SettingsInput(updateTargets: widget.updateTargets,carbsTarget: carbsTarget, proteinTarget: proteinTarget, fatTarget: fatTarget),
            
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
import 'package:flutter/material.dart';
import 'package:macro_counter_app/models/Macro.dart';
import 'package:macro_counter_app/screens/settings/widgets/settings_inputs.dart';
import 'package:macro_counter_app/screens/settings/widgets/user_details.dart';
import 'package:macro_counter_app/services/auth.dart';
import 'package:macro_counter_app/shared/dialog.dart';

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
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double carbsTarget = widget.macros != null ? widget.macros[0].goalValue : 0;
    double proteinTarget =
        widget.macros != null ? widget.macros[1].goalValue : 0;
    double fatTarget = widget.macros != null ? widget.macros[2].goalValue : 0;

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                final action = await Dialogs.yesAbortDialog(
                    context, "Logout", "Are you sure you want to logout?");
                if (action == DialogAction.yes) {
                  await _auth.signOut();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
          title: Text('Settings'),
        ),
        body: Column(
          children: <Widget>[
            ExpansionTile(
              trailing: Icon(Icons.track_changes),
              title: Text('Targets'),
              subtitle: Text('Set your macronutrient targets here'),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(17),
                  child: SettingsInput(
                      updateTargets: widget.updateTargets,
                      carbsTarget: carbsTarget,
                      proteinTarget: proteinTarget,
                      fatTarget: fatTarget),
                ),
              ],
            ),
             ExpansionTile(
              trailing: Icon(Icons.person),
              title: Text('Account'),
              children: <Widget>[
                UserDetail(),
              ],
            )
          ],
        ));
  }
}

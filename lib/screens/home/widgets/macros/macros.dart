import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/models/Macro.dart';
import 'package:macro_counter_app/screens/home/widgets/macros/macro_bar.dart';
import 'package:macro_counter_app/services/database.dart';
import 'package:macro_counter_app/shared/dialog.dart';
import 'package:macro_counter_app/shared/loading.dart';
import 'package:macro_counter_app/models/UserFirestoreData.dart';
import 'package:provider/provider.dart';
import 'package:macro_counter_app/models/User.dart';

class Macros extends StatelessWidget {
  final List<Macro> macros;
  Macros(this.macros);

  @override
  Widget build(BuildContext context) {
    final userAppData = Provider.of<UserData>(context);
    final user = Provider.of<User>(context);

    if (userAppData == null) {
      return Loading();
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MacroBar(
            'Carbs',
            userAppData.currentCarbs,
            userAppData.targetCarbs,
          ),
          MacroBar(
            'Protein',
            userAppData.currentProtein,
            userAppData.targetProtein,
          ),
          MacroBar(
            'Fat',
            userAppData.currentFat,
            userAppData.targetFat,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () async {
                final action = await Dialogs.yesAbortDialog(context, "Reset", "Do you want to reset your macros?");
                if(action == DialogAction.yes) {
                  DatabaseService(uid:user.uid).resetMacros();
                }
              },
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

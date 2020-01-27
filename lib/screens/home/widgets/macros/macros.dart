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
  final Function resetMacros;
  Macros(this.macros, this.resetMacros);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Macro carbs = macros[0];
    Macro protein = macros[1];
    Macro fat = macros[2];
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MacroBar(
            'Carbs',
            carbs.value,
            carbs.goalValue,
          ),
          MacroBar(
            'Protein',
            protein.value,
            protein.goalValue,
          ),
          MacroBar(
            'Fat',
            fat.value,
            fat.goalValue,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () async {
                final action = await Dialogs.yesAbortDialog(
                    context, "Reset", "Do you want to reset your macros?");
                if (action == DialogAction.yes) {
                  resetMacros(user);
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

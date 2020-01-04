import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/models/Macro.dart';
import 'package:macro_counter_app/widgets/macro_bar.dart';
import 'package:macro_counter_app/models/UserFirestoreData.dart';
import 'package:provider/provider.dart';

class Macros extends StatelessWidget {
  final List<Macro> macros;
  Macros(this.macros);

  @override
  Widget build(BuildContext context) {
    final userAppData = Provider.of<UserData>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MacroBar('Carbs',userAppData.currentCarbs, userAppData.targetCarbs, ),
        MacroBar('Protein',userAppData.currentProtein, userAppData.targetProtein, ),
        MacroBar('Fat',userAppData.currentFat, userAppData.targetFat, ),
      ],
    );
  }
}

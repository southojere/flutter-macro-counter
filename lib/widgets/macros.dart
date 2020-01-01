import 'package:flutter/widgets.dart';
import 'package:macro_counter_app/models/Macro.dart';
import 'package:macro_counter_app/widgets/macro_bar.dart';

class Macros extends StatelessWidget {
  final List<Macro> macros;
  Macros(this.macros);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: this.macros.map((macro) {
        return MacroBar(macro.label, macro.value, macro.goalValue);
      }).toList(),
    );
  }
}

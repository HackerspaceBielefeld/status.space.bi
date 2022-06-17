import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SofaWidget extends StatelessWidget {
  int maxsofa;
  int occupiedsofa;

  SofaWidget(this.maxsofa, this.occupiedsofa);

  @override
  Widget build(BuildContext context) {
    List<Widget> sofas = [];
    for (int i = 0; i < maxsofa; i++) {
      Color sofacolor;
      if (occupiedsofa == null) {
        sofacolor = Colors.grey;
      } else if (i < occupiedsofa) {
        sofacolor = Colors.red;
      } else {
        sofacolor = Colors.green;
      }
      sofas.add(Icon(
        MdiIcons.sofaSingle,
        color: sofacolor,
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: sofas,
    );
  }
}

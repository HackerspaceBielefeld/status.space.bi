import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum OpenCloseStatus { ocsOpenGuests, ocsOpenMembers, ocsClosed }

class OpenCloseBanner extends StatelessWidget {
  OpenCloseStatus ocs;

  OpenCloseBanner(this.ocs);
  @override
  Widget build(BuildContext context) {
    String text;
    Color color;
    switch (ocs) {
      case OpenCloseStatus.ocsOpenGuests:
        {
          text = 'Offen für Gäste';
          color = Colors.green;
          break;
        }
      case OpenCloseStatus.ocsOpenMembers:
        {
          text = 'Nur für Vereinsmitglieder';
          color = Colors.orange;
          break;
        }
      case OpenCloseStatus.ocsClosed:
        {
          text = 'Leider geschlossen';
          color = Colors.red;
          break;
        }
    }
    return Container(
      margin: const EdgeInsets.all(13.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 4),
      ),
      child: Text(text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: color,
          )),
    );
  }
}

class OpenStatusWidget extends StatelessWidget {
  OpenCloseStatus ocs;
  bool leaving;

  OpenStatusWidget(this.ocs, this.leaving);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    items.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(MdiIcons.door),
        VerticalDivider(),
        Text(
          'Open / Closed',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    ));

    items.add(OpenCloseBanner(ocs));

    if (leaving) {
      items.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
          ),
          Text('Achtung! Wir schließen bald', style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ));
    }

    return Column(
      children: items,
    );
  }
}

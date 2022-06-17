import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webapp/widgets/sofawidget.dart';

enum CoronaMode { cmPersons, cmGGG, cmStage0 }

class CoronaInfoWidget extends StatelessWidget {
  CoronaMode cm;
  int maxpersons;
  int occupiedpersons;

  CoronaInfoWidget(this.cm, this.maxpersons, this.occupiedpersons);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MdiIcons.virusOutline),
          VerticalDivider(),
          Text(
            'Coronainfo für Gäste',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Aktuelle Auslastung:'),
          SofaWidget(this.maxpersons, this.occupiedpersons),
        ],
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(MdiIcons.faceMaskOutline), VerticalDivider(), Flexible(child: Text('Trage eine Mund-/Nasenbedeckung in den Räumen'))]),
      /*Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(MdiIcons.testTube), VerticalDivider(), Flexible(child: Text('Bringe einen nicht mehr als 24h alten Test mit bzw.'))]),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(MdiIcons.bookOpenVariant), VerticalDivider(), Flexible(child: Text('einen Nachweis der Impfung oder Genesung.'))]),*/
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(MdiIcons.bookOpenVariant), VerticalDivider(), Flexible(child: Text('Bringe einen Nachweis der Impfung oder Genesung mit.'))]),
      Text(''),
      /*Flexible(
        child: Text(
          'Bitte beachtet, dass Ihr für GGG einen Test von einer anerkannten Teststelle mitbringt.',
          textAlign: TextAlign.center,
        ),
      ),
      Flexible(child: Text('Selbsttests sind leider nicht zugelassen.', textAlign: TextAlign.center)),
      Text(''),*/
    ]);
  }
}

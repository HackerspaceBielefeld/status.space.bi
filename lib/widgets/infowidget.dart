import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.humanGreeting),
            VerticalDivider(),
            Text(
              'Der Verein',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Anschrift: '),
            SelectableText('Blomestraße 27 - 33609 Bielefeld'),
            IconButton(
                onPressed: () async {
                  Uri url = Uri.parse(
                      "https://www.openstreetmap.org/#map=18/52.03695/8.56914");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                icon: Icon(MdiIcons.mapSearch))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Telefon: '),
            SelectableText('+49 (0) 521 337 322 42'),
            IconButton(
                onPressed: () async {
                  Uri url = Uri.parse("tel:+4952133732242");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                icon: Icon(MdiIcons.phoneDial))
          ],
        )
      ],
    );
  }
}

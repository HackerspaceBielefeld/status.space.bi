import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SpaceStatusDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Impressum: '),
              //SelectableText('https://hackerspace-bielefeld.de/space/impressum/'),
              IconButton(
                  onPressed: () async {
                    const url = "https://hackerspace-bielefeld.de/space/impressum/";
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  icon: Icon(MdiIcons.web))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Datenschutz: '),
              //SelectableText('https://hackerspace-bielefeld.de/space/datenschutz/'),
              IconButton(
                  onPressed: () async {
                    const url = "https://hackerspace-bielefeld.de/space/datenschutz/";
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  icon: Icon(MdiIcons.web))
            ],
          ),
        ],
      ),
    );
  }
}

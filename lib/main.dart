import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webapp/providers/calendarprovider.dart';
import 'package:webapp/providers/statusprovider.dart';
import 'package:webapp/widgets/drawer.dart';
import 'package:webapp/widgets/infowidget.dart';
import 'package:webapp/widgets/openstatuswidget.dart';
import 'package:webapp/animation/spaceLoadingIndicator.dart';

import 'widgets/calendarinfowidget.dart';

Future<void> main() async {
  //runApp(ChangeNotifierProvider<StatusProvider>(create: (_) => StatusProvider(), child: SpaceStatusApp()));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<StatusProvider>(create: (_) => StatusProvider()),
    ChangeNotifierProvider<CalendarProvider>(create: (_) => CalendarProvider()),
  ], child: SpaceStatusApp()));
}

class SpaceStatusApp extends StatefulWidget {
  @override
  _SpaceStatusAppState createState() => _SpaceStatusAppState();
}

class _SpaceStatusAppState extends State<SpaceStatusApp> {
  @override
  void initState() {
    super.initState();
    context.read<StatusProvider>().update();
    context.read<CalendarProvider>().update();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceStatus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpaceStatusPage(),
    );
  }
}

class SpaceStatusPage extends StatefulWidget {
  @override
  _SpaceStatusPageState createState() => _SpaceStatusPageState();
}

class _SpaceStatusPageState extends State<SpaceStatusPage> {
  late Timer refreshTimer;
  late int refreshSeconds;

  @override
  void initState() {
    super.initState();
    refreshSeconds = 120;
    refreshTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      int tmpseconds = refreshSeconds;
      tmpseconds--;
      if (tmpseconds == 0) {
        tmpseconds = 120;
        Provider.of<StatusProvider>(context, listen: false).update();
        Provider.of<CalendarProvider>(context, listen: false).update();
      }

      setState(() {
        refreshSeconds = tmpseconds;
      });
    });
  }

  @override
  void dispose() {
    refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Space.bi Status'),
      ),
      drawer: SpaceStatusDrawer(),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
              onPressed: () {
                Provider.of<StatusProvider>(context, listen: false).update();
                setState(() {
                  refreshSeconds = 120;
                });
              },
              icon: Icon(Icons.refresh),
              label: Text('Neu laden (Automatisch in ' +
                  refreshSeconds.toString() +
                  ' Sekunden)'))
        ],
      )),
      body: SingleChildScrollView(
        child: Consumer<StatusProvider>(builder: (context, status, _) {
          if (status.loading) {
            return Center(child: SpaceLoadingIndicator());
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/img/rakete.png'),
                    width: 100,
                  ),
                  VerticalDivider(),
                  OpenStatusWidget(status.data.ocs, status.data.leaving),
                ],
              ),
              Divider(),
              CalendarInfoWidget(),
              Divider(),
              //CoronaInfoWidget(status.data.coronaMode, status.data.maxPersons, status.data.occupiedPersons),
              //Divider(),
              InfoWidget(),
            ],
          );
        }),
      ),
    ));
  }
}

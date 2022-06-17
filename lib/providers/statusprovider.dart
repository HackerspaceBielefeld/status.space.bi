import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webapp/widgets/coronainfowidget.dart';
import 'package:webapp/widgets/openstatuswidget.dart';

class RelevantSpaceAPIData {
  OpenCloseStatus ocs;
  bool leaving;
  CoronaMode coronaMode;
  int maxPersons;
  int occupiedPersons;

  readFromJson(Map<String, dynamic> data) {
    String tmpocs = data['state']['openstate'];
    if (tmpocs == "openguests") {
      ocs = OpenCloseStatus.ocsOpenGuests;
    } else if (tmpocs == "membersonly" || tmpocs == "memberonly") {
      ocs = OpenCloseStatus.ocsOpenMembers;
    } else {
      ocs = OpenCloseStatus.ocsClosed;
    }

    leaving = data['state']['leaving'];

    String tmpcoronamode = data['corona']['mode'];

    switch (tmpcoronamode) {
      case "GGG":
        {
          coronaMode = CoronaMode.cmGGG;
          break;
        }
      case "Persons":
        {
          coronaMode = CoronaMode.cmPersons;
          break;
        }
      case "Stage0":
        {
          coronaMode = CoronaMode.cmStage0;
          break;
        }
      default:
        {
          coronaMode = CoronaMode.cmGGG;
          break;
        }
    }

    maxPersons = data['corona']['max'];
    occupiedPersons = data['corona']['current'];
  }
}

class StatusProvider extends ChangeNotifier {
  RelevantSpaceAPIData data = RelevantSpaceAPIData();
  bool loading = true;

  String baseURI;

  StatusProvider() {
    if (kIsWeb) {
      baseURI = '/status.json?x=';
    } else {
      baseURI = 'https://status.space.bi/status.json?x=';
    }
  }

  Future<void> update() async {
    loading = true;

    //await Future.delayed(Duration(seconds: 1));

    print("update json");
    http.Response response = await http.get(Uri.parse(baseURI + Random().nextInt(99999).toString()), headers: {"Cache-Control": "no-store"});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsondata = jsonDecode(response.body);
      //print(jsondata);
      data.readFromJson(jsondata);
    } else {
      throw Exception('Failed to load status');
    }
    loading = false;
    notifyListeners();
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:webapp/widgets/openstatuswidget.dart';

class RelevantSpaceAPIData {
  late OpenCloseStatus ocs;
  late bool leaving;
  late int maxPersons;
  late int occupiedPersons;

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
  }
}

class StatusProvider extends ChangeNotifier {
  RelevantSpaceAPIData data = RelevantSpaceAPIData();
  bool loading = true;

  late String baseURI;

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

    print("update status json");
    http.Response response = await http.get(
        Uri.parse(baseURI + Random().nextInt(99999).toString()),
        headers: {"Cache-Control": "no-store"});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsondata = jsonDecode(response.body);
      try {
        data.readFromJson(jsondata);
      } catch (e) {
        print("error parse status");
        print(e.toString());
      }
    } else {
      throw Exception('Failed to load status');
    }
    loading = false;
    notifyListeners();
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:webapp/models/calendaritem.dart';

class CalendarProvider extends ChangeNotifier {
  CalendarItems? items;
  bool loading = true;

  late String baseURI;

  CalendarProvider() {
    if (kIsWeb) {
      baseURI = '/calendar.json?x=';
    } else {
      baseURI = 'https://status.space.bi/calendar.json?x=';
    }
  }

  Future<void> update() async {
    loading = true;

    //await Future.delayed(Duration(seconds: 1));

    print("update calendar json");
    http.Response response = await http.get(Uri.parse(baseURI + Random().nextInt(99999).toString()), headers: {"Cache-Control": "no-store"});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsondata = jsonDecode(response.body);
      try {
        items = CalendarItems.fromJson(jsondata['items'] as List<dynamic>);
      } catch(e){
        print("error parse calendar");
        print(e.toString());
      }
    } else {
      throw Exception('Failed to load status');
    }
    loading = false;
    notifyListeners();
  }
}

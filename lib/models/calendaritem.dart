import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code));
}

// 0 ist kein Wochentag
const List<String> weekdaynames = ["-", "Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"];

class CalendarItem {
  final String summary;
  final int tsstart;
  final int tsend;
  final List<dynamic> categories;
  final Color color;
  final bool cancelled;

  String get weekday => weekdaynames[DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).weekday];
  int get day => DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).day;
  int get month => DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).month;
  int get hour => DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).hour;
  int get minute => DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).minute;

  CalendarItem({this.summary, this.tsstart, this.tsend, this.categories, this.color, this.cancelled});

  factory CalendarItem.fromJson(Map<String, dynamic> json) {
    if (!kReleaseMode) {
      print('Parse calendar item');
    }

    return CalendarItem(
        summary: json['summary'] as String,
        tsstart: json['tsstart'] as int,
        tsend: json['tsend'] as int,
        categories: json['categories'] as List<dynamic>,
        color: hexToColor(json['color'] as String),
        cancelled: json['cancelled'] == null ? false : true);
  }
}

class CalendarItems {
  final List<CalendarItem> items;

  CalendarItems({this.items});

  factory CalendarItems.fromJson(List<dynamic> json) {
    List<CalendarItem> items = [];

    json.forEach((value) {
      items.add(CalendarItem.fromJson(value));
    });

    return CalendarItems(items: items);
  }
}

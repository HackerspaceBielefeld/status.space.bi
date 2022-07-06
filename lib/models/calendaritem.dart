import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code));
}

// 0 ist kein Wochentag
const List<String> weekdaynames = [
  "-",
  "Mo",
  "Di",
  "Mi",
  "Do",
  "Fr",
  "Sa",
  "So"
];
final Map<String, IconData> iconLib = {
  'account-group': MdiIcons.accountGroup,
  'ballot-outline': MdiIcons.ballotOutline,
  'shield-lock-open-outline': MdiIcons.shieldLockOpenOutline,
  'snake': MdiIcons.snake,
};

IconData summaryIcon(String? iconname) {
  if (iconname != null) {
    if (iconLib.containsKey(iconname)) {
      return iconLib[iconname]!;
    }
  }

  return MdiIcons.helpRhombusOutline;
}

class CalendarItemVisualMarker {
  final IconData itemicon;
  final Color itemcolor;

  CalendarItemVisualMarker({required this.itemicon, required this.itemcolor});

  factory CalendarItemVisualMarker.fromJson(Map<String, dynamic> json) {
    return CalendarItemVisualMarker(
        itemicon: summaryIcon(json['name']),
        itemcolor: hexToColor(json['color'] as String));
  }
}

class CalendarItem {
  final String summary;
  final int tsstart;
  final int tsend;
  final List<dynamic> categories;
  final Color color;
  final CalendarItemVisualMarker icon;
  final bool cancelled;

  String get weekday =>
      weekdaynames[DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).weekday];
  int get day => DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).day;
  int get month => DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).month;
  int get hour => DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).hour;
  int get minute => DateTime.fromMillisecondsSinceEpoch(tsstart * 1000).minute;

  CalendarItem(
      {required this.summary,
      required this.tsstart,
      required this.tsend,
      required this.categories,
      required this.color,
      required this.icon,
      required this.cancelled});

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
        icon: CalendarItemVisualMarker.fromJson(json['icon']),
        cancelled: json.containsKey('cancelled') ? true : false);
  }
}

class CalendarItems {
  final List<CalendarItem> items;

  CalendarItems({required this.items});

  factory CalendarItems.fromJson(List<dynamic> json) {
    List<CalendarItem> items = [];

    json.forEach((value) {
      items.add(CalendarItem.fromJson(value));
    });

    return CalendarItems(items: items);
  }
}

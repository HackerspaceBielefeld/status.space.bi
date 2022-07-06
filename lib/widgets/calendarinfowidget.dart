import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:webapp/models/calendaritem.dart';
import 'package:webapp/providers/calendarprovider.dart';

class CalendarListTile extends StatelessWidget {
  CalendarItem item;

  CalendarListTile(this.item);

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = [];

    categories.add(Icon(
      Icons.door_front_door,
      color: item.color,
    ));

    item.categories.forEach((name) => categories.add(Chip(
        labelStyle: TextStyle(fontSize: 10),
        backgroundColor: Colors.grey.shade200,
        label: Text(name),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)));

    List<TextStyle> ts;

    if (!item.cancelled) {
      ts = [
        TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ];
    } else {
      ts = [
        TextStyle(fontSize: 13, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),
        TextStyle(fontSize: 12, fontWeight: FontWeight.normal, decoration: TextDecoration.lineThrough),
        TextStyle(fontSize: 12, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),
        TextStyle(fontSize: 11, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),
      ];
    }

    return ListTile(
      //tileColor: item.color,
      leading: Column(
        children: [
          Text(
            item.weekday + ".",
            style: ts[0],
          ),
          Text(
            item.day.toString().padLeft(2, '0') + "." + item.month.toString().padLeft(2, '0') + ".",
            style: ts[1],
          )
        ],
      ),
      trailing: Column(
        children: [
          Text(
            'Start',
            style: ts[3],
          ),
          Text(
            item.hour.toString().padLeft(2, '0'),
            style: ts[2],
          ),
          Text(
            item.minute.toString().padLeft(2, '0'),
            style: ts[1],
          ),
        ],
      ),
      title: Row(
        children: [
          Icon(
            item.icon.itemicon,
            color: item.icon.itemcolor,
          ),
          VerticalDivider(),
          Text(
            item.summary,
            style: ts[0],
          ),
        ],
      ),
      subtitle: Row(
        children: categories,
      ),
    );
  }
}

class CalendarInfoWidget extends StatelessWidget {
  CalendarInfoWidget();

  @override
  Widget build(BuildContext context) {
    CalendarItems? calItems = Provider.of<CalendarProvider>(context, listen: true).items;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MdiIcons.calendarClock),
          VerticalDivider(),
          Text(
            'Termine und Veranstaltungen',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      calItems == null
          ? CircularProgressIndicator()
          : Builder(builder: (context) {
              /*List<Widget> wl = [];

              calItems.items.forEach((item) {
                wl.add(CalendarListTile(item));
                wl.add(Divider());
              });
              wl.removeLast();

              return SizedBox(
                width: 400,
                height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: wl,
                ),
              );
              */
              return Container(
                height: 300,
                width: 400,
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, idx) {
                        return CalendarListTile(calItems.items[idx]);
                      },
                      separatorBuilder: (context, idx) => Divider(),
                      itemCount: calItems.items.length),
                ),
              );
            }),
    ]);
  }
}

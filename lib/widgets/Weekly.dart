import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/weatherAPI.dart';
import 'package:weather_app/util/util.dart' as util;

import 'ItemListTempWeek.dart';

class Weekly extends StatelessWidget {
  final String location;
  final Color textListCol, containerItemListCol;

  Weekly(
      {Key key, this.location, this.textListCol, this.containerItemListCol})
      : super(key: key);

  String yearMonth;

  var formatYM = DateFormat("yyyy-MM-");
  var formatYMD = DateFormat("yyyy-MM-dd");
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    yearMonth = formatYM.format(currentDate);

    return FutureBuilder(
        future: getListToday(
            util.appID, location == null ? util.locationDefault : location),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            List contentList = content['list'];

            double TemperatureSum = 0;
            int qntdForPercorrido = 0;
            List listDays = [];
            List listDaysUnique = [];
            List listTemp = [];
            List listTempDIA = [];
            List listMapDataTemp = [];
            List iconList = [];

            contentList.forEach((f) {
              if (f.toString().contains("${yearMonth}")) {
                listDays
                    .add(formatYMD.format(DateTime.parse(f['dt_txt'])));
              }
            });

            listDaysUnique = listDays.toSet().toList();

            for (int i = 0; i < listDaysUnique.length; i++) {
              contentList.forEach((f) {
                String dataListUnique;
                dataListUnique = listDaysUnique[i];

                if (f.toString().contains('$dataListUnique')) {
                  TemperatureSum = TemperatureSum +
                      double.parse(
                          f['main']['temp'].toString().replaceAll(',', '.'));
                  if (f.toString().contains('$dataListUnique 15:00:00')) {
                    iconList.add({
                      'data': '$dataListUnique 15:00:00',
                      'icon': f['weather'][0]['icon'].toString()
                    });
                  }
                  qntdForPercorrido++;
                }
              });

              listTemp.add(TemperatureSum);

              print('Total Temp:${listDaysUnique[i]} :$TemperatureSum');
              print(
                  'Average Temp:${listDaysUnique[i]} :${(TemperatureSum /
                      qntdForPercorrido)}');

              listTempDIA.add((TemperatureSum / qntdForPercorrido).round());
              listMapDataTemp.add({
                'data': listDaysUnique[i],
                'temp_media':
                    (TemperatureSum / qntdForPercorrido).toStringAsFixed(2)
              });

              TemperatureSum = 0;
              qntdForPercorrido = 0;
            }
            print(
                'COMPARISON DATES (LIST MAP TEMP and NOW): ${listMapDataTemp[0]['data']}  -  ${formatYMD.format(currentDate)}');
            if (listMapDataTemp[0]
                .toString()
                .contains(formatYMD.format(currentDate))) {
              listMapDataTemp.removeAt(0);
            }
            if(listMapDataTemp.length >5){
              listMapDataTemp.removeLast();
            }

            print('----------------------');
            print('LIST TEMP: $listTemp');
            print('LIST TEMP AVERAGE: $listTempDIA');
            print('LIST MAP DAY_TEMP: $listMapDataTemp');

            print('----------------------');
            if (iconList.length < 5) {
              iconList.add({'icon': '03d'});
            }

            print('ICON LIST: $iconList');

            return Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: listMapDataTemp.length,
                itemBuilder: (context, index) {
                  return ItemListTempWeek(
                    data: listMapDataTemp[index]['data'].toString(),
                    temp: listMapDataTemp[index]['temp_media'].toString(),
                    textCol: textListCol,
                    containerCol: containerItemListCol,
                    animation: iconList[index]['icon'],
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

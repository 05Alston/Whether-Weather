import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemListTempWeek extends StatelessWidget {
  final String data;
  final String temp;
  final Color textCol;
  final Color containerCol;
  final String animation;

  const ItemListTempWeek(
      {Key key,
      this.data,
      this.temp,
      this.textCol,
      this.containerCol,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatDayName = DateFormat.E('en_US');
    DateFormat formatDayMonth = DateFormat('dd/MM');
    DateTime dateReceived = DateTime.parse(data);
    String dataFormatted = formatDayName.format(dateReceived);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: containerCol,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: width * 0.2,
                padding: EdgeInsets.only(
                    left: width * 0.02,
                    right: width * 0.02,
                    top: width * 0.04,
                    bottom: width * 0.04),
                decoration: BoxDecoration(
                    //color: Colors.blue[900],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue[900], Colors.purple]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(5),
                        topRight: Radius.circular(25))),
                child: Center(
                  child: Text(
                    dataFormatted,
                    style: TextStyle(
                        fontSize: width * 0.04, //17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: width * 0.1,
                    width: width * 0.1,
                    child: FlareActor(
                      'assets/weather3.flr',
                      fit: BoxFit.contain,
                      animation: animation,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15, left: 10),
                    child: Text(
                      '${temp[0]}${temp[1].replaceAll(".", "")}°c',
                      style: TextStyle(
                          fontSize: width * 0.05, //20,
                          color: textCol,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: width * 0.015,
        )
      ],
    );
  }
}

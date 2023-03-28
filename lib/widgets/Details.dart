import 'package:flutter/material.dart';
import 'package:weather_app/api/weatherAPI.dart';
import 'package:weather_app/util/util.dart' as util;

class Details extends StatelessWidget {
  final String city;
  final Color corUmi, textCol, visibleCol, corVent, prevCol, nextCol;

  const Details(
      {Key key,
      this.city,
      this.corUmi,
      this.textCol,
      this.visibleCol,
      this.corVent,
      this.prevCol,
      this.nextCol})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getWeather(
            util.appID, city == null ? util.locationDefault : city),
        builder: (context, snapshot) {

          Map resJson = snapshot.data;

          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                Container(
                  
                  decoration: BoxDecoration(
                      color: corUmi, borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(width * 0.022),
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Icon(Icons.invert_colors,
                              color: Colors.blue[800], size: width * 0.08 //35,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Humidity: ${resJson['main']['humidity']}%',
                          style: TextStyle(
                              fontSize: width * 0.04, //20,
                              color: textCol),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: visibleCol, borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(width * 0.022),
                        decoration: BoxDecoration(
                            color: Colors.orange[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Icon(Icons.wb_sunny,
                              color: Colors.orange[800],
                              size: width * 0.08 //35,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Visibility: ${resJson['visibility']} m',
                          style: TextStyle(
                              fontSize: width * 0.04, //20,
                              color: textCol),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: corVent, borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(width * 0.022),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Icon(Icons.gesture,
                              color: Colors.grey[800], size: width * 0.08 //35,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Wind speed: ${resJson['wind']['speed']} km/h',
                          style: TextStyle(
                              fontSize: width * 0.04, //20,
                              color: textCol),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: prevCol, borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(width * 0.022),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Icon(Icons.tonality,
                              color: Colors.green[800], size: width * 0.08 //35,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Pressure: ${resJson['main']['pressure']} hPa',
                          style: TextStyle(
                              fontSize: width * 0.04, //20,
                              color: textCol),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: nextCol,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(width * 0.022),
                        decoration: BoxDecoration(
                            color: Colors.indigo[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Icon(Icons.filter_drama,
                              color: Colors.indigo[800],
                              size: width * 0.08 //35,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Cloudy: ${resJson['clouds']['all']}%',
                          style: TextStyle(
                              fontSize: width * 0.04, //20,
                              color: textCol),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

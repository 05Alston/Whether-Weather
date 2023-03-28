import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/weatherAPI.dart';
import 'package:weather_app/util/util.dart' as util;
import 'package:weather_app/widgets/Details.dart';
import 'package:weather_app/widgets/Weekly.dart';

class HomePage extends StatefulWidget {
  final String latitude,longitude;

  const HomePage({Key key, this.latitude, this.longitude}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _locationInfo;
  TextEditingController _locationController = TextEditingController();
  var formatData = DateFormat('EEEE, dd MMMM', 'en_US');
  DateTime currentDate = DateTime.now();
  bool valueSwitch = false;
  bool visibleLocation;
  Color corUmi, visibleCol, corVent, prevCol, nextCol;
  Color textCol, corFundo, textListCol, containerItemListCol;
  bool visibleDetails;

  
  setCores() {
    if (valueSwitch == false) {
      corUmi = Colors.blue[100];
      visibleCol = Colors.orange[100];
      corVent = Colors.grey[200];
      prevCol = Colors.green[100];
      nextCol = Colors.indigo[100];
      textCol = Colors.grey[900];
      corFundo = Colors.white;
      textListCol = Colors.grey[900];
      containerItemListCol = Colors.grey[100];
    } else {
      corUmi = Colors.grey[850];
      visibleCol = Colors.grey[850];
      corVent = Colors.grey[850];
      prevCol = Colors.grey[850];
      nextCol = Colors.grey[850];
      textCol = Colors.white;
      corFundo = Colors.grey[900];
      textListCol = Colors.orange[600];
      containerItemListCol = Colors.grey[850];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCores();
    visibleLocation = true;
    visibleDetails = true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;    

    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'ClearWeather',
          style: TextStyle(
            fontSize: width * 0.05,
            color: textCol.withOpacity(0.7),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          Switch(
              value: valueSwitch,
              onChanged: (value) {
                setState(() {
                  valueSwitch = value;
                  setCores();
                  //ThemeData.dark();
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          //height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Text("${widget.latitude} --- ${widget.longitude} "),
              Padding(
                padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1, top: width * 0.04),
                child: FutureBuilder(
                    future: getWeather(
                        util.appID,
                        _locationInfo == null
                            ? util.locationDefault
                            : _locationInfo),
                    builder: (context, snapshot) {
                      Map resJson = snapshot.data;
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      visibleLocation = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.location_on,
                                    size: width * 0.08, //30,
                                    color: valueSwitch == false
                                        ? Colors.grey[850]
                                        : Colors.orange[600],
                                  ),
                                ),
                                Visibility(
                                    visible: visibleLocation,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          visibleLocation = false;
                                        });
                                      },
                                      child: Text(
                                        '${resJson['name']}',
                                        style: TextStyle(
                                            fontSize: width * 0.09, //40,
                                            fontWeight: FontWeight.bold,
                                            color: textCol),
                                      ),
                                    )),
                                Visibility(
                                    visible: !visibleLocation,
                                    child: Expanded(
                                        child: TextField(
                                      autofocus: true,
                                      style: TextStyle(color: textCol),
                                      controller: _locationController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      onSubmitted: (_) {
                                        setState(() {
                                          if (_locationController.text == null ||
                                              _locationController.text.isEmpty) {
                                          } else {
                                            _locationInfo =
                                                _locationController.text;
                                          }
                                          visibleLocation = true;
                                        });
                                      },
                                    ))),
                              ],
                            ),
                            SizedBox(
                              height: width * 0.009,
                            ),
                            Text('       ${formatData.format(currentDate)}',
                              style: TextStyle(
                                  fontSize: width * 0.04 /*17*/,
                                  color: Colors.orange[700]),
                            ),
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Container(
                              height: height * 0.25, //200,
                              width: width,
                              //color: Colors.grey[300],
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                      top: 0,
                                      right: -20,
                                      child: Container(
                                        height: height * 0.22, //200,
                                        width: width * 0.55, //250,
                                        child: FlareActor(
                                          'assets/weather3.flr',
                                          fit: BoxFit.contain,
                                          animation: resJson['weather'][0]
                                                  ['icon']
                                              .toString(),
                                        ),
                                      )),
                                  Positioned(
                                    top: 10,
                                    left: 0,
                                    child: Text(
                                      '${resJson['main']['temp'].toString()[0]}' +
                                          '${resJson['main']['temp'].toString()[1].replaceAll(".", "")}°',
                                      style: TextStyle(
                                          fontSize: width * 0.29, //120,
                                          fontWeight: FontWeight.w600,
                                          color: textCol),
                                    ),
                                  ),
                                  Positioned(
                                    top: width * 0.33,//140,
                                    left: 5,
                                    child: Row(
                                      children: <Widget>[
                                        Text('Min: ${resJson['main']['temp_min']}°',
                                          style: TextStyle(
                                              fontSize: width * 0.038, //15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey[400]),
                                        ),
                                        Text('/ Max: ${resJson['main']['temp_max']}°',
                                          style: TextStyle(
                                              fontSize: width * 0.038, //15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey[400]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: width * 0.03,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            visibleDetails = true;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 500),
                                          padding: visibleDetails == true
                                              ? EdgeInsets.all(0)
                                              : EdgeInsets.only(
                                                  left: 25,
                                                  right: 25,
                                                  top: 10,
                                                  bottom: 10),
                                          decoration: BoxDecoration(
                                              border: visibleDetails == true
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.orange[600],
                                                      width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: Text('Details',
                                              style: TextStyle(
                                                  fontSize:
                                                      visibleDetails == true
                                                          ? width * 0.05 //20
                                                          : width * 0.05, //20,
                                                  color: textCol,
                                                  fontWeight:
                                                      visibleDetails == true
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            visibleDetails = false;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 500),
                                          padding: visibleDetails == false
                                              ? EdgeInsets.all(0)
                                              : EdgeInsets.only(
                                                  left: 25,
                                                  right: 25,
                                                  top: 10,
                                                  bottom: 10),
                                          decoration: BoxDecoration(
                                              border: visibleDetails == false
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.orange[600],
                                                      width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: Text('Previous',
                                              style: TextStyle(
                                                  fontSize:
                                                      visibleDetails == false
                                                          ? width * 0.05 //20
                                                          : width * 0.05, //20,
                                                  color: textCol,
                                                  fontWeight:
                                                      visibleDetails == false
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: width * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
              Container(
                height: visibleDetails == false ? 0 : height * 0.5, //400,
                //visible: visibleDetalhes,
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 0),
                  child: Details(
                    city: _locationInfo,
                    nextCol: nextCol,
                    prevCol: prevCol,
                    textCol: textCol,
                    corUmi: corUmi,
                    corVent: corVent,
                    visibleCol: visibleCol,
                  ),
                ),
              ),
              Container(
                height: visibleDetails == true ? 0 : height * 0.6, //400,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 300),
                    child: Weekly(
                      location: _locationInfo,
                      containerItemListCol: containerItemListCol,
                      textListCol: textListCol,
                    ),
                    ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

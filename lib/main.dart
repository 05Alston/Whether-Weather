import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/screens/HomePage.dart';

main(List<String> args) {
  initializeDateFormatting('en_US',null).then((_){
    runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData.light(),
    debugShowCheckedModeBanner: false,
  ));
  });
}
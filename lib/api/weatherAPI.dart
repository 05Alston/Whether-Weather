import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'as http;

Future<Map> getWeather(String appID,String location)async{
  String urlAPI ='http://api.openweathermap.org/data/2.5/weather?q=${location}&appid=${appID}&units=metric';
  http.Response response = await http.get(Uri.parse(urlAPI));

  if(response.statusCode == 200){
    return json.decode(response.body);
  }else{
    throw Exception("API CALL FAILED");
  }
}

//http://api.openweathermap.org/data/2.5/forecast?q=Rio de Janeiro&appid=bfcd22a403f236384e97aade0514c99b&units=metric
//api.openweathermap.org/data/2.5/weather?lat=-22.8432338&lon=-43.261246&appid=bfcd22a403f236384e97aade0514c99b&units=metric

Future<Map> getListToday(String appID,String location)async{
  String urlAPI ='http://api.openweathermap.org/data/2.5/forecast?q=${location}&appid=${appID}&units=metric';
  http.Response response = await http.get(Uri.parse(urlAPI));

  if(response.statusCode == 200){
    return json.decode(response.body);
  }else{
    throw Exception("API CALL FAILED");
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:location/location.dart' as lc;
import 'package:util/models/weather/weather_stat.dart';

import 'package:util/utility/changable.dart';

Future<LocationPermission> locationPermission(BuildContext context) async {

  LocationPermission permission;
  lc.Location location = lc.Location();


  bool _serviceEnabled;
  _serviceEnabled = await location.serviceEnabled();

  if(!_serviceEnabled){
    _serviceEnabled = await location.requestService();
    if(!_serviceEnabled){
      Navigator.pop(context);
    }
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      print("Stopped at permission");
      return LocationPermission.denied;
    }
  }

  if (permission == LocationPermission.deniedForever) {

    return LocationPermission.deniedForever;
  }
  return LocationPermission.always;


}

getData(bool mine,BuildContext context, {double latitude=0,double longitude=0}) async{


  LocationPermission permission;
  lc.Location location = lc.Location();

  bool _serviceEnabled;
  _serviceEnabled = await location.serviceEnabled();

  if(!_serviceEnabled){
    _serviceEnabled = await location.requestService();
    if(!_serviceEnabled){
      Navigator.pop(context);
    }
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      print("Stopped at permission");
      return LocationPermission.denied;
    }
  }

  if (permission == LocationPermission.deniedForever) {

    return LocationPermission.deniedForever;
  }
  //return LocationPermission.always;

  //hhhhh


  double lat,lon;
  if(mine){
    var x = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat=x.latitude;
    lon=x.longitude;
  }else{
    lat=latitude;
    lon=longitude;
  }



  Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&appid=$ApiKey'));
  
  Response responseLoc = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$ApiKey'));
  
  var data = jsonDecode(response.body);
  var dataLoc = jsonDecode(responseLoc.body);


  return [data,dataLoc, [lat,lon]];



  // print(hour.first['dt']);

}










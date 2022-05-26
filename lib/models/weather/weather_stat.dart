import 'package:flutter/services.dart';

class HourWeather {
  int dt=0;
  double temp=0;
  double feelsLike=0;
  int pressure=0;
  int humidity=0;
  double dewPoint=0;
  double uvi=0;
  int clouds=0;
  int visibility=0;
  double windSpeed=0;
  int windDeg=0;
  double windGust=0;
  List<Weather> weather=[];
  double pop=0;

  HourWeather();

  /*HourWeather(
      {required this.dt,
        required this.temp,
        required this.feelsLike,
        required this.pressure,
        required this.humidity,
        required this.dewPoint,
        required this.uvi,
        required this.clouds,
        required this.visibility,
        required this.windSpeed,
        required this.windDeg,
        required this.windGust,
        required this.weather,
        required this.pop});*/

  HourWeather.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp']+.0;
    feelsLike = json['feels_like']+.0;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point']+.0;
    uvi = json['uvi']+.0;
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed']+.0;
    windDeg = json['wind_deg'];
    windGust = json['wind_gust']+.0;
    if (json['weather'] != null) {
      weather = new List<Weather>.empty(growable: true);
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    pop = json['pop']+.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['uvi'] = this.uvi;
    data['clouds'] = this.clouds;
    data['visibility'] = this.visibility;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    data['wind_gust'] = this.windGust;
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    data['pop'] = this.pop;
    return data;
  }
}

class Weather {
  int id=0;
  String main="0";
  String description="0";
  String icon="0";

  /*Weather({this.id, this.main, this.description, this.icon});*/

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}



class DailyWeather {
  int dt=0;
  int sunrise=0;
  int sunset=0;
  int moonrise=0;
  int moonset=0;
  double moonPhase=0;
  Temp temp=Temp();
  FeelsLike feelsLike=FeelsLike();
  int pressure=0;
  int humidity=0;
  double dewPoint=0;
  double windSpeed=0;
  int windDeg=0;
  List<Weather> weather=[];
  int clouds=0;
  double pop=0;
  double rain=0;
  double uvi=0;



  DailyWeather.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase']+.0;
    temp = (json['temp'] != null ? new Temp.fromJson(json['temp']) : null)!;
    feelsLike = (json['feels_like'] != null
        ? new FeelsLike.fromJson(json['feels_like'])
        : null)!;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point']+.0;
    windSpeed = json['wind_speed']+.0;
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weather = new List<Weather>.empty(growable: true);
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop']+.0;
    rain = json['rain']==null?0:json['rain']+.0;
    uvi = json['uvi']+.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['moonrise'] = this.moonrise;
    data['moonset'] = this.moonset;
    data['moon_phase'] = this.moonPhase;
    if (this.temp != null) {
      data['temp'] = this.temp.toJson();
    }
    if (this.feelsLike != null) {
      data['feels_like'] = this.feelsLike.toJson();
    }
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    data['clouds'] = this.clouds;
    data['pop'] = this.pop;
    data['rain'] = this.rain;
    data['uvi'] = this.uvi;
    return data;
  }
}

class Temp {
  double day=0;
  double min=0;
  double max=0;
  double night=0;
  double eve=0;
  double morn=0;
  Temp();


  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day']+.0;
    min = json['min']+.0;
    max = json['max']+.0;
    night = json['night']+.0;
    eve = json['eve']+.0;
    morn = json['morn']+.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['min'] = this.min;
    data['max'] = this.max;
    data['night'] = this.night;
    data['eve'] = this.eve;
    data['morn'] = this.morn;
    return data;
  }
}

class FeelsLike {
  double day=0;
  double night=0;
  double eve=0;
  double morn=0;

  FeelsLike();

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day']+.0;
    night = json['night']+.0;
    eve = json['eve']+.0;
    morn = json['morn']+.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['night'] = this.night;
    data['eve'] = this.eve;
    data['morn'] = this.morn;
    return data;
  }
}




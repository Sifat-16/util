
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:util/models/weather/weather_stat.dart';
import 'package:util/screens/weather/weather_service.dart';



class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {




  @override
  Widget build(BuildContext context) {
        return Scaffold(

          body: CustomWeatherBody(),
        );
  }
}

class CustomWeatherBody extends StatefulWidget {
  const CustomWeatherBody({Key? key}) : super(key: key);

  @override
  _CustomWeatherBodyState createState() => _CustomWeatherBodyState();
}

class _CustomWeatherBodyState extends State<CustomWeatherBody> {
  PanelController spc = PanelController();
  MapController mc = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //locationPermission(context);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white
          ),

          /*actions: [
            GestureDetector(
              onTap: (){
                spc.open();

              },
              child: IconButton(onPressed: (){
                spc.open();
              }, icon: Icon(Icons.map),
              splashColor: Colors.transparent,
              )
            )
          ],*/

        ),
        body: SlidingUpPanel(
          controller: spc,
          minHeight: 0,
          backdropEnabled: true,



          panel: Container(
            decoration: BoxDecoration(

            ),
            child: Container(),
          ),
          body: CustomBody(),
        ),
    );
  }

 /* _flutter_map(BuildContext ctx) {
    return FlutterMap(
          mapController: mc,
          options: MapOptions(
            center: LatLng(0.0, 0.0),
            zoom: 13.0,
          ),
          layers: [
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(0.0, 0.0),
                  builder: (ctx) =>
                      Container(
                        child: Icon(Icons.location_on, color: Colors.green,),
                      ),
                ),
              ],
            ),
          ],
          children: <Widget>[
            TileLayerWidget(options: TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
            )),

          ],
        );

  }*/
}

class CustomBody extends StatefulWidget {
  CustomBody({Key? key}) : super(key: key);

  @override
  _CustomBodyState createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {


  late dynamic hourWeather;
 

  @override
  void initState() {
    // TODO: implement initState
    //locationPermission(context);
    hourWeather=getData(true, context);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: hourWeather,
      builder: (context, snapshot) {
        List<HourWeather> hw = [];
        List<DailyWeather>dw=[];
        if(snapshot.hasData){

        Iterable hour = snapshot.data[0]["hourly"];
        Iterable daily = snapshot.data[0]["daily"];
        hour.forEach((element) {
          hw.add(HourWeather.fromJson(element));
        });
        daily.forEach((element) {
          dw.add(DailyWeather.fromJson(element));
        });
        }
        return snapshot.connectionState==ConnectionState.done&&snapshot.hasData?Column(

          children: [

            _showUpper(snapshot.data[1]),

            _showMidList(hw),





            //second Column

            _showLower(dw)



          ],
        ):snapshot.connectionState==ConnectionState.waiting?Center(
            child: Lottie.asset("assets/redan.json", height: 100, width: 100)
        ):Center(child: Text("Something went wrong", style: TextStyle(color: Colors.white),),);
      }
    );
  }

  _showUpper(data){

    return Container(
      height: MediaQuery.of(context).size.height*.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon(Icons.location_off_rounded, color: Colors.white, size: 20,),
              SizedBox(width: 8,),
              Text(
                "${data["name"]}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23

                ),
              ),
            ],
          ),
          //SizedBox(height: 10,),
          Text(
            "Sync: ${DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(DateTime.fromMillisecondsSinceEpoch(data["dt"]*1000))} ${DateFormat(DateFormat.HOUR_MINUTE).format(DateTime.fromMillisecondsSinceEpoch(data["dt"]*1000))}",
            style: TextStyle(
                color: Colors.white.withOpacity(.6)
            ),
          ),
          //SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon(Icons.wb_sunny_rounded, color: Colors.yellow, size: 50,),
              Container(

                child: Image.network('http://openweathermap.org/img/wn/${data["weather"][0]["icon"]}@2x.png'),


              ),
              Text("${double.parse((data["main"]["temp"]-273.15).toString()).roundToDouble()}\u00B0",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50
                ),

              ),

            ],
          ),
          //SizedBox(height: 15,),
          Text("${double.parse((data["main"]["temp_max"]-273.15).toString()).roundToDouble()}\u00B0/${double.parse((data["main"]["temp_min"]-273.15).toString()).roundToDouble()}\u00B0 Feels like ${double.parse((data["main"]["feels_like"]-273.15).toString()).roundToDouble()}\u00B0",
            style: TextStyle(
                color: Colors.white.withOpacity(0.6)
            ),

          ),
          Text("${data["weather"][0]["description"]}",
            style: TextStyle(
                color: Colors.white.withOpacity(0.8)
            ),

          ),
        ],
      ),
    );
  }

  _showMidList(List<HourWeather> data) {
    return Container(
      height: MediaQuery.of(context).size.height*.30,
      //color: Colors.green,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Icon(Icons.menu, color: Colors.white.withOpacity(0.8),),
                //
                Text("Hourly",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),

                ),
                Icon(Icons.keyboard_arrow_right, color: Colors.white.withOpacity(0.8),)
              ],
            ),
          ),

          
          Expanded(
            child: Container(
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1)
             ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                  itemBuilder: (context, index){
                  var item = data[index];
                    return CustomTimeSchedule(hw: item,);
                  }
              ),
            ),
          ),




        ],
      ),
    );
  }

  _showLower(List<DailyWeather> data){
    return Container(
      height: MediaQuery.of(context).size.height*.25,

child: Column(
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Daily",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
          /*Text("Yesterday: 29\u00B0/16\u00B0",
            style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.bold
            ),
          )*/
        ],
      ),
    ),
    Expanded(
      child: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1)

        ),
        //color: Colors.white,

          child: Column(
            children: [

              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      var item = data[index];
                      return CustomDailySchedule(dw: item,);
                    }
                ),
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTimeSchedule(time:"Today", icon:Icons.wb_sunny_sharp,perc:0, temp:29.0),
                  CustomTimeSchedule(time:"Fri", icon:Icons.wb_sunny_sharp,perc:0, temp:29.0),
                  CustomTimeSchedule(time:"Sat", icon:Icons.wb_sunny_sharp,perc:0, temp:29.0),
                  CustomTimeSchedule(time:"Sun", icon:Icons.wb_sunny_sharp,perc:0, temp:29.0),
                  CustomTimeSchedule(time:"Mon", icon:Icons.wb_sunny_sharp,perc:0, temp:29.0),
                  CustomTimeSchedule(time:"Tue", icon:Icons.wb_sunny_sharp,perc:0, temp:29.0),
                ],
              ),*/

              SizedBox(height: 20,),



            ],
          ),

      ),
    )
  ],
),
    );
  }
}


class CustomTimeSchedule extends StatelessWidget {
  CustomTimeSchedule({Key? key, required this.hw}) : super(key: key);
  HourWeather hw;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(DateFormat(DateFormat.HOUR).format(DateTime.fromMillisecondsSinceEpoch(hw.dt*1000)),
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.bold
            ),
            ),
           // SizedBox(height: 10,),
            //Icon(icon, color: Colors.yellow, size: 20,),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellowAccent
              ),
              child: Image.network(
                    "http://openweathermap.org/img/wn/${hw.weather[0].icon}@2x.png",
                scale: 2.5,
                ),
            ),


            Text(
              hw.weather[0].main,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(MdiIcons.weatherWindy, color: Colors.lightBlueAccent, size: 10,),


                Text("${hw.windSpeed} m/s",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.bold

                    )
                )
              ],
            ),
           // SizedBox(height: 10,),
            Text("${(hw.temp-273.15).roundToDouble()}\u00B0",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.bold

                )
            )

          ],

      ),
    );
  }
}


class CustomDailySchedule extends StatelessWidget {
  CustomDailySchedule({Key? key, required this.dw}) : super(key: key);
  DailyWeather dw;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(DateFormat(DateFormat.WEEKDAY).format(DateTime.fromMillisecondsSinceEpoch(dw.dt*1000)),
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.bold
            ),
          ),
          // SizedBox(height: 10,),
          //Icon(icon, color: Colors.yellow, size: 20,),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellowAccent
            ),
            child: Image.network(
              "http://openweathermap.org/img/wn/${dw.weather[0].icon}@2x.png",
              scale: 2.5,
            ),
          ),


          Text(
            dw.weather[0].description,
            style: TextStyle(
                color: Colors.white
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(MdiIcons.weatherWindy, color: Colors.lightBlueAccent, size: 10,),


              Text("${dw.windSpeed} m/s",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.bold

                  )
              )
            ],
          ),
          // SizedBox(height: 10,),
          Text("${(dw.temp.day-273.15).roundToDouble()}\u00B0",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.bold

              )
          )

        ],

      ),
    );
  }
}






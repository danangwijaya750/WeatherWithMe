import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:weather_with_me/model/weather_model.dart';

class ForecastScreen extends StatelessWidget {
  final WeatherModel data;

  ForecastScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = new DateTime.fromMillisecondsSinceEpoch(data.current.dt * 1000);
    String day =DateFormat("MMM, dd").format(date);
    print(data.daily.length);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor("#47BFDF"), HexColor("#4A91FF")],
                begin: const FractionalOffset(0.8, 0.0),
                end: const FractionalOffset(0.0, 0.8),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            new GestureDetector(
              onTap: ()=>{
                Navigator.pop(context)
              },
              child:Container(
                  margin: EdgeInsets.only(top: 52, left: 20),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("assets/back.png"),
                        width: 32,
                        height: 32,
                      ),
                      Text(
                        "Back",
                        style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ],
                  )),
            ),

            Container(
                margin: EdgeInsets.only(top: 49, left: 30,right: 30),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today",style:TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                  Text(day,style:TextStyle(color: Colors.white,fontSize: 18),),
                ],
              )
            ),
            Container(
              height: 150,
              margin: EdgeInsets.only(top: 40),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: this.data.hourly.length,
                separatorBuilder: (context, index) => Divider(
                  height: 160,
                ),
                padding: EdgeInsets.only(left: 5, right: 20),
                // ignore: missing_return
                itemBuilder: (context, index) {
                  var item = this.data.hourly[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: _itemHourly(context, item),
                  );
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 0, left: 30,right: 30),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Next Forecast",style:TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                  ],
                )
            ),
            Flexible(
              child: 
              Container(
                margin:EdgeInsets.only(top:0, left: 30, right: 30,),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: this.data.daily.length,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    var item = this.data.daily[index];
                    return Container(
                      child: _itemDaily(context, item),
                    );
                  },
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  _itemDaily(context, Daily itemData){
     var date = new DateTime.fromMillisecondsSinceEpoch(itemData.dt * 1000);
     String day = DateFormat("MMM, dd").format(date);
     int intHour = int.parse(DateFormat("HH").format(date));
     return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: Text(
                day,
                style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.all(10),
              child: _getImage(itemData.weather[0].main, intHour)),
          Container(
              margin: EdgeInsets.all(10),
              child: Text(
                ((itemData.temp.max+itemData.temp.max)/2).toString() + "\u00B0",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ],
      ),
    );
  }

  _itemHourly(context, Hourly itemData) {
    var date = new DateTime.fromMillisecondsSinceEpoch(itemData.dt * 1000);
    String hours = DateFormat("HH : mm").format(date);
    int intHour = int.parse(DateFormat("HH").format(date));
    return Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(5),
              child: Text(
                itemData.temp.toString() + "\u00B0",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
          Container(
              margin: EdgeInsets.all(5),
              child: _getImage(itemData.weather[0].main, intHour)),
          Container(
              margin: EdgeInsets.all(5),
              child: Text(
                hours,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
        ],
      ),
    );
  }

  _getImage(main, hours) {
    if (main == "Clear") {
      if (hours >= 18 || hours < 5) {
        return Image(
            image: AssetImage('assets/moon.png'), width: 43, height: 43);
      } else {
        return Image(
            image: AssetImage('assets/sunny.png'), width: 43, height: 43);
      }
    } else if (main == "Rain") {
      return Image(image: AssetImage('assets/rain.png'), width: 43, height: 43);
    } else if (main == "Thunderstorm") {
      return Image(
          image: AssetImage('assets/thunder.png'), width: 43, height: 43);
    } else if (main == "Clouds") {
      if (hours >= 18 || hours < 5) {
        return Image(
            image: AssetImage('assets/moon_cloudy.png'), width: 43, height: 43);
      } else {
        return Image(
            image: AssetImage('assets/sun_cloudy.png'), width: 43, height: 43);
      }
    }
  }
}

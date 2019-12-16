import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for UI
  String time; //time in that location
  String date;
  String flag; //flag image of the location
  String url; //location url for http request
  bool isDaytime; // to get the time is day or not

  WorldTime({this.location, this.flag, this.url});

  //making Future makes a method temporarily future type like promise in javascript
  //future makes a method return a value of future type or if reuest not completed
  //then return void type
  Future<void> getTime() async {
    // Error handling through try catch blocks in the event of any failure
    try{
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      // coverting the responce object into array and making it list
      Map data = jsonDecode(response.body);
      //print(data);
      String datetime = data['utc_datetime'];

      String hours_offset = data['utc_offset'].substring(0,3);
      String minutes_offset = data['utc_offset'].substring(4,6);
      // create DateTime object
      DateTime currentTime = DateTime.parse(datetime);

      //adding adding extra hours from hours offset to the currentTime
      currentTime = currentTime.add(Duration(hours: int.parse(hours_offset)));

      //adding adding extra minutes from minutes offset to the currentTime
      currentTime = currentTime.add(Duration(minutes: int.parse(minutes_offset)));

      isDaytime = currentTime.hour >= 6 && currentTime.hour <= 18 ? true : false;

      date = DateFormat.MMMMEEEEd().format(currentTime);

      //parsing detetime to actual format using intl package
      time = DateFormat.jm().format(currentTime);
    }
    catch(e){
      //this will not be displayed to screen but to console
      print("Opps, an error occured: $e");

      //if some error occurs then display this message to the screen
      time = 'couldn\'t find the location';
    }

  }
}
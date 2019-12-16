import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'Loading...';

  //making it async because we want to have await
  void setupTime() async {

    //get time from instance of WorldTime to request time of the location
    WorldTime currentTime = WorldTime(location: 'India', flag: 'london.png', url: 'asia/kolkata');

    //await will make it wait till we get the response by request
    await currentTime.getTime();

    //after getting response navigate and sending to home screen with required data as arguments
    //pushReplacementNamed is a method which has third parameter to help whils sending data
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': currentTime.location,
      'flag': currentTime.flag,
      'time': currentTime.time,
      'isDaytime': currentTime.isDaytime,
      'date': currentTime.date,
    });

  }

  @override
  // initState is a kind of constructor which is global to all the methods
  void initState() {
    // TODO: implement initState
    //super keyword helps to get all the parent class methods and varibles
    super.initState();
    //run setupTime method while screen loads
    setupTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: SpinKitDualRing(
          color: Colors.white,
          size: 100.0,
        ),
      )
    );
  }
}

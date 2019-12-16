import 'package:flutter/material.dart';
import 'package:world_time/screens/choose_location.dart';
import 'package:world_time/screens/home.dart';
import 'package:world_time/screens/loading.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/' : (contex) => Loading(),
      '/home' : (contex) => Home(),
      '/location' : (contex) => ChooseLocation(),
    }
)
);
import 'package:flutter/material.dart';
import 'package:search_app/searchPage.dart';

void main() {
  runApp(RestaurantSearchApp());
}

class RestaurantSearchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black45,
      ),
      home: SearchPage(title: 'Search Page'),
    );
  }
}

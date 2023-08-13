import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smeet/Screens/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Text('GoogleNavBar'),
        backgroundColor : Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Text("Home"),
      ),
      bottomNavigationBar: NavBar(selected: 0,)
    );
  }
}

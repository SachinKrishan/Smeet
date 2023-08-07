import 'package:flutter/material.dart';
import '/Screens/bottom_navbar.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreen createState() => _CreateScreen();
}

class _CreateScreen extends State<CreateScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 20,
          title: const Text('Create Meetings'),
          backgroundColor : Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Text("works" )
        ),
        bottomNavigationBar: NavBar()
    );
  }
}
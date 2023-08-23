import 'package:flutter/material.dart';
import '/Screens/createMeeting/create_form.dart';
import '/Screens/bottom_navbar.dart';
import 'package:smeet/Screens/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 20,
            title: const Text('Profile'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Text("Availability",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                   SizedBox(height: 20),
                   Text("9:00 AM - 5:00 PM",
                       style: TextStyle( fontSize: 20)),
             SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => LoginScreen(setLoadingState: (){}, setAuthenticatedState: (){}, setUnauthenticatedState: (){})));

                      },
                      child: Text("SIGN OUT".toUpperCase()),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavBar(selected: 2)),
    );
  }
}
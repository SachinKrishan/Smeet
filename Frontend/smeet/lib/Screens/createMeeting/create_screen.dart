import 'package:flutter/material.dart';
import '/Screens/createMeeting/create_form.dart';
import '/Screens/bottom_navbar.dart';

class CreateMeetingScreen extends StatelessWidget {
  const CreateMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 20,
            title: const Text('Create Meetings'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  CreateScreenForm(),
                  //SignUpFooterWidget(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavBar(selected: 1)),
    );
  }
}

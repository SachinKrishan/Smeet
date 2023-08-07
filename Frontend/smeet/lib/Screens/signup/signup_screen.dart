import 'package:flutter/material.dart';
import 'signup_header.dart';
import 'signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                FormHeaderWidget(
                  image: 'assets/s.png',
                  title: "Get on board!",
                  subTitle: "Do meetings the easy way",
                  imageHeight: 0.15,
                ),
                SignUpFormWidget(context: context,),
                //SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
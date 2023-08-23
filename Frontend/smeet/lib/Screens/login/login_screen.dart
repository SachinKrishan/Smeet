import 'package:flutter/material.dart';
import 'login_header.dart';
import 'login_form.dart';
import 'login_footer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(
      {Key? key,
        required this.setLoadingState,
        required this.setAuthenticatedState,
        required this.setUnauthenticatedState})
      : super(key: key);

  final VoidCallback setLoadingState;
  final VoidCallback setAuthenticatedState;
  final VoidCallback setUnauthenticatedState;

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeaderWidget(),
                LoginForm(
                  setLoadingState: widget.setLoadingState,
                  setAuthenticatedState:  widget.setAuthenticatedState,
                  setUnauthenticatedState:  widget.setUnauthenticatedState,
                ),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
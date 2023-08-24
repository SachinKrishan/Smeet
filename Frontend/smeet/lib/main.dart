import 'package:flutter/material.dart';
import 'package:smeet/Screens/login/login_screen.dart';

import 'Screens/loading/loading_screen.dart';
import 'Screens/home/home_scree.dart';


void main() {
  runApp(const SocialAuth());
}


class SocialAuth extends StatefulWidget {
  const SocialAuth({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<SocialAuth> createState() => _SocialAuthState();
}

class _SocialAuthState extends State<SocialAuth> {
  bool isProgressing = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    initAuth();
    super.initState();
  }

  initAuth() async {
    setLoadingState();
    final bool isAuthenticated = false;
    if (isAuthenticated) {
      setAuthenticatedState();
    } else {
      setUnauthenticatedState();
    }
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
    });
  }

  setAuthenticatedState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
    });
  }

  setUnauthenticatedState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocialAuthApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Builder(
          builder: (context) {
            if (isProgressing) {
              return const LoadingScreen();
            } else if (isLoggedIn) {
              return HomeScreen();
            } else {
              return LoginScreen(
                setLoadingState: setLoadingState,
                setAuthenticatedState: setAuthenticatedState,
                setUnauthenticatedState: setUnauthenticatedState,
              );
            }
          },
        ),
      ),
    );
  }
}
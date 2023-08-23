import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smeet/Screens/home/home_scree.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String email;
  String password;

  User(this.email, this.password);
}

class LoginForm extends StatefulWidget {
  const LoginForm(
      {Key? key,
        required this.setLoadingState,
        required this.setAuthenticatedState,
        required this.setUnauthenticatedState})
      : super(key: key);

  final VoidCallback setLoadingState;
  final VoidCallback setAuthenticatedState;
  final VoidCallback setUnauthenticatedState;

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {

  Future<void> loginUser(BuildContext context, String email, String password) async {
    final String apiUrl = "http://172.20.2.246:8080/signin"; // Replace with your API endpoint

    widget.setLoadingState();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String?, String?>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Successful login, you can handle the response here
        widget.setAuthenticatedState();
        final responseBody = json.decode(response.body);
        //print('Login successful: $responseBody');
        //print(responseBody["user"]["name"]);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', responseBody["user"]["name"]);

        Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // Login failed, handle the error
        widget.setUnauthenticatedState();
        print('Login failed: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      // Network or other errors
      print('Error occurred: $e');
    }
  }

  User user = User('', '');

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: TextEditingController(text: user.email),
              onChanged: (value) {
                user.email = value;
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: "E-mail",
                  //hintText: tEmail,
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: TextEditingController(text: user.password),
              onChanged: (value) {
                user.password = value;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "??",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text("Forget pass?")),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print(user.email);
                  print(user.password);
                  loginUser(context, user.email, user.password);
                },
                child: Text("Login".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
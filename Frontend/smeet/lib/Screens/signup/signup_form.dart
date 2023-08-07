import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smeet/Screens/login/login_screen.dart';

class User {
  String email;
  String password;

  User(this.email, this.password);
}

class SignUpFormWidget extends StatelessWidget {
  SignUpFormWidget({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  Future save() async {
    final url = Uri.parse("http://172.20.2.246:8080/signup");

      final userData = {
      'email': user.email,
      'password': user.password
      };

      final res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData), // Convert your data to JSON
    );

    print(res.body);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  User user = User('', '');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("Full name"),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: TextEditingController(text: user.email),
              onChanged: (value) {
                user.email = value;
              },
              decoration: const InputDecoration(
                  label: Text("email"), prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("phone"), prefixIcon: Icon(Icons.numbers)),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: TextEditingController(text: user.password),
              onChanged: (value) {
                user.password = value;
              },
              decoration: const InputDecoration(
                  label: Text("password"), prefixIcon: Icon(Icons.fingerprint)),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  save();
                },
                child: Text("Sign up".toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}

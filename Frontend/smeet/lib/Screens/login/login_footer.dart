import 'package:flutter/material.dart';
import '../signup/signup_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: Container(
            height: 60,
            child: OutlinedButton.icon(
              icon: const Image(image: AssetImage("assets/googleLogo.png"), width: 20.0),
              onPressed: () {},
              label: const Text("Sign in with Google")
              )
            ),
          ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen(),
          ));},
          child: Text.rich(
            TextSpan(
                text: "Don't have an account?",
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(text: " Sign up", style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}
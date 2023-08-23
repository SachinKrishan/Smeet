import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import '../services/auth_service.dart';


class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen(
      {Key? key,
        required this.setLoadingState,
        required this.setAuthenticatedState,
        required this.setUnauthenticatedState})
      : super(key: key);

  final VoidCallback setLoadingState;
  final VoidCallback setAuthenticatedState;
  final VoidCallback setUnauthenticatedState;

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  // @override
  // void initState() {
  //   super.initState();
  //
  //   _googleSignIn.onCurrentUserChanged
  //       .listen((GoogleSignInAccount? account) async {
  //     // In mobile, being authenticated means being authorized...
  //     bool isAuthorized = account != null;
  //
  //     setState(() {
  //       _currentUser = account;
  //       _isAuthorized = isAuthorized;
  //     });
  //
  //     // Now that we know that the user can access the required scopes, the app
  //     // can call the REST API.
  //   });
  //
  //   // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
  //   //
  //   // It is recommended by Google Identity Services to render both the One Tap UX
  //   // and the Google Sign In button together to "reduce friction and improve
  //   // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
  //   _googleSignIn.signInSilently();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueAccent,
      child: Center(
        child: ElevatedButton(
          onPressed: loginAction,
          child: const Text('Login'),
        ),
      ),
    );
  }

  Future<void> loginAction() async {
    widget.setLoadingState();
    final authSuccess = false;
    const List<String> scopes = <String>[
      'email',
    ];

    GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId: 'your-client_id.apps.googleusercontent.com',
      scopes: scopes,
    );
    if (authSuccess) {
      widget.setAuthenticatedState();
    } else {
      widget.setUnauthenticatedState();
    }
  }
}
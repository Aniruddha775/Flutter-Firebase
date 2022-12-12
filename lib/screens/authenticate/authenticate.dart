import 'package:brew_cafe/screens/authenticate/Sign_in.dart';
import 'package:brew_cafe/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  toggleView() {
    setState(() {
      showSignIn =
          !showSignIn; //changes from true to false and vice versa as it toggles it
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}

import 'package:brew_cafe/models/user.dart';
import 'package:brew_cafe/screens/authenticate/authenticate.dart';
import 'package:brew_cafe/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    //Return either Home or Authenticate Widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

import 'package:brew_cafe/models/user.dart';
import 'package:brew_cafe/screens/wrapper.dart';
import 'package:brew_cafe/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      catchError: (User, user) {},
      value: AuthService().user, //Accessing user stream from auth.dart
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

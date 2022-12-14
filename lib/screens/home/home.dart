import 'package:brew_cafe/models/brew.dart';
import 'package:brew_cafe/screens/home/settings_form.dart';
import 'package:brew_cafe/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_cafe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_cafe/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child: SettingsForm(),
            );
          });
    }

    final AuthService _auth = AuthService();
    return StreamProvider<List<Brew>>.value(
      // initialData: [],
      value: DatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 253, 236, 190),
        appBar: AppBar(
          title: Text('Brew Cafe'),
          backgroundColor: Color.fromARGB(255, 233, 151, 0),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signout();
              },
            ),
            TextButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
            ),
          ],
        ),
        body: Container(
          child: BrewList(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

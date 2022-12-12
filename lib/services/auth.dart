import 'package:brew_cafe/models/user.dart';
import 'package:brew_cafe/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; //_ means private can be used in this file only
  //create user object based on FirebaseUser
  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //Auth change User Stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  //sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user; // ? Assing null to User
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString()); //catches the error
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

import 'package:brew_cafe/models/brew.dart';
import 'package:brew_cafe/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    Map<String, dynamic> data = {
      'name': name,
      'strength': strength,
      'sugars': sugars,
    };

    return await brewCollection.doc(uid).set(data);
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0',
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        // name: snapshot.data('name'),
        // sugars: snapshot['sugars'],
        // strength: snapshot['strength'],

        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength'));
  }

  //get brews Stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

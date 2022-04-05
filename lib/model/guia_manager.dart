import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_guia/model/guia.dart';

class GuiaManager extends ChangeNotifier {
  GuiaManager() {
    _loadCurrentGuia();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Guia? guia;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signIn({
    required Guia client,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: client.email!, password: client.password!);

      await _loadCurrentGuia(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch (e) {
      onFail(e.code);
    }
    loading = false;
  }

  Future<void> signUP(
      {required Guia client,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: client.email!, password: client.password!);

      client.id = result.user!.uid;
      this.guia = guia;

      await client.saveData();
      onSuccess();
    } on PlatformException catch (e) {
      onFail(e.code);
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    guia = null;
    notifyListeners();
  }

  Future<void> _loadCurrentGuia({User? firebaseUser}) async {
    final User? currentUser = firebaseUser ?? auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('guides').doc(currentUser.uid).get();
      guia = Guia.fromDocument(docUser);
      notifyListeners();
    }
  }
}

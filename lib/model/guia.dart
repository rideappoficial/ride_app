import 'package:cloud_firestore/cloud_firestore.dart';

class Guia {
  Guia({this.id, this.name, this.categoria, this.email, this.password});

  Guia.fromDocument(DocumentSnapshot document) {
    id = document.id;
    //name = document['name'] as String;
    email = document['email'] as String;
  }

  String? id;
  String? name;
  String? categoria;
  String? email;
  String? password;
  String? confirmPassword;

  String? cpf;
  String? telefone;
  String? cep;
  String? rua;
  String? bairro;
  String? cidade;
  String? estado;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('guides/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}

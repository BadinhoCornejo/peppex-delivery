import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String uid;
  String name;

  CategoryModel({this.uid, this.name});

  factory CategoryModel.fromMap(DocumentSnapshot documentSnapshot) {
    return CategoryModel(
      uid: documentSnapshot.id,
      name: documentSnapshot.data()['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
      };
}

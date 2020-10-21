import 'package:meta/meta.dart';

class Category {
  final String uid;
  final String categoryName;

  Category({
    @required this.uid,
    @required this.categoryName
  });
  
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        uid: json['uid'],
        categoryName: json['categoryName']);
  }

}
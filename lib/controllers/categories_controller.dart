import 'package:get/get.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:peppex_delivery/models/models.dart';

class CategoriesController extends GetxController {
  static CategoriesController to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rx<CategoryModel> category = Rx<CategoryModel>();
  Rx<List<CategoryModel>> categoriesStream = Rx<List<CategoryModel>>();
  Rx<List<ProductModel>> productsStream = Rx<List<ProductModel>>();

  @override
  void onInit() {
    category.bindStream(defaultCategory());
  }

  CategoryModel get currentCategory => category.value;

  Stream<List<CategoryModel>> listCategories() {
    return _db.collection('categories').snapshots().map((QuerySnapshot query) =>
        query.docs.map((e) => CategoryModel.fromMap(e)).toList());
  }

  Stream<List<ProductModel>> listProducts(String categoryId) {
    return _db
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) =>
            query.docs.map((e) => ProductModel.fromMap(e)).toList());
  }

  Stream<CategoryModel> defaultCategory() {
    return _db
        .collection('categories')
        .limit(1)
        .snapshots()
        .map((QuerySnapshot query) => CategoryModel.fromMap(query.docs[0]));
  }

  void setCurrentCategory(CategoryModel categoryModel) {
    category.value = categoryModel;
    update();
  }
}

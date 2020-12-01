import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String uid;
  String address;
  String customerName;
  String customerDoc;
  String customerPhone;
  num active;
  DateTime orderDate;
  num amount;
  List<String> products;

  OrderModel({
    this.uid,
    this.address,
    this.customerName,
    this.customerDoc,
    this.customerPhone,
    this.active,
    this.orderDate,
    this.amount,
    this.products,
  });

  factory OrderModel.fromMap(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data();
    List<String> products = new List<String>();
    data['products'].forEach((product){
      products.add(product);
    });

    return OrderModel(
      uid: documentSnapshot.id,
      address: data['address'] ?? '',
      customerName: data['customerName'] ?? '',
      customerDoc: data['customerDoc'] ?? '',
      customerPhone: data['customerPhone'] ?? '',
      active: data['active'],
      orderDate: data['orderDate'].toDate() ?? '',
      amount: data['amount'] ?? 0,
      products: products,
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "customerName": customerName,
        "customerDoc": customerDoc,
        "customerPhone": customerPhone,
        "active": active,
        "orderDate": orderDate,
        "amount": amount,
        "products": products,
      };
}

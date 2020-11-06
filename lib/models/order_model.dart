import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String uid;
  String address;
  String customerName;
  String customerDoc;
  DateTime orderDate;
  num amount;
  List<String> products;

  OrderModel(
      {this.uid,
      this.address,
      this.customerName,
      this.customerDoc,
      this.orderDate,
      this.amount,
      this.products});

  factory OrderModel.fromMap(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data();

    return OrderModel(
      uid: documentSnapshot.id,
      address: data['address'] ?? '',
      customerName: data['customerName'] ?? '',
      customerDoc: data['customerDoc'] ?? '',
      orderDate: data['orderDate'] ?? '',
      amount: data['amount'] ?? 0,
      products: data['products'],
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "customerName": customerName,
        "customerDoc": customerDoc,
        "orderDate": orderDate,
        "amount": amount,
        "products": products,
      };
}

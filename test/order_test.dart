import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:google_sign_in/testing.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/models/cartItem_model.dart';
import 'package:peppex_delivery/models/models.dart';

main() {
  final db = MockFirestoreInstance();

  group('Order process works correctly', () {
    // ORDER AMOUNT
    test('Calculate amount succes 1', () async {
      const userUid = '1';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 1,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      expect(await orderController.calcAmount(userDoc), 25);
    });
    test('Calculate amount success 2', () async {
      const userUid = '2';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 4,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      expect(await orderController.calcAmount(userDoc), 100);
    });
    test('Calculate amount fails 1', () async {
      const userUid = '3';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 5,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      orderController.calcAmount(userDoc).catchError((e) {
        expect(e.message,
            'La cantidad no debe superar las 4 unidades o debe ser mayor o igual a 1');
      });
    });
    test('Calculate amount fails 2', () async {
      const userUid = '4';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 99,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      orderController.calcAmount(userDoc).catchError((e) {
        expect(e.message,
            'La cantidad no debe superar las 4 unidades o debe ser mayor o igual a 1');
      });
    });
    test('Calculate amount fails 3', () async {
      const userUid = '5';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 0,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      orderController.calcAmount(userDoc).catchError((e) {
        expect(e.message,
            'La cantidad no debe superar las 4 unidades o debe ser mayor o igual a 1');
      });
    });
    test('Calculate amount fails 4', () async {
      const userUid = '6';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: -1,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      orderController.calcAmount(userDoc).catchError((e) {
        expect(e.message,
            'La cantidad no debe superar las 4 unidades o debe ser mayor o igual a 1');
      });
    });
    test('Calculate amount fails 5', () async {
      const userUid = '7';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: -1,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 1,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      orderController.calcAmount(userDoc).catchError((e) {
        expect(e.message, 'El precio debe ser mayor o igual a 1');
      });
    });
    test('Calculate amount fails 7', () async {
      const userUid = '8';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 0,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 1,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      orderController.calcAmount(userDoc).catchError((e) {
        expect(e.message, 'El precio debe ser mayor o igual a 1');
      });
    });
    // ORDER CREATION
    test('Create order success 1', () async {
      const userUid = '9';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 1,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      String customerName = 'Juan Soto';
      String customerDoc = '71778079';
      String address = 'Primavera';
      num amount = await orderController.calcAmount(userDoc);

      expect(
          await orderController.newOrder(
              userDoc, customerName, customerDoc, address, amount),
          true);
    });
    test('Create order success 2', () async {
      const userUid = '10';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 2,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      String customerName = 'Juan Soto';
      String customerDoc = '71778079';
      String address = 'Primavera';
      num amount = await orderController.calcAmount(userDoc);

      expect(
          await orderController.newOrder(
              userDoc, customerName, customerDoc, address, amount),
          true);
    });
    test('Create order fails 1', () async {
      const userUid = '11';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 6,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 4,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      String customerName = 'Juan Soto';
      String customerDoc = '71778079';
      String address = 'Primavera';
      num amount = await orderController.calcAmount(userDoc);

      await orderController
          .newOrder(userDoc, customerName, customerDoc, address, amount)
          .catchError((e) {
        expect(e.message, 'Monto no válido');
      });
    });
    test('Create order fails 2', () async {
      const userUid = '12';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 126,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 1,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      String customerName = 'Juan Soto';
      String customerDoc = '71778079';
      String address = 'Primavera';
      num amount = await orderController.calcAmount(userDoc);

      await orderController
          .newOrder(userDoc, customerName, customerDoc, address, amount)
          .catchError((e) {
        expect(e.message, 'Monto no válido');
      });
    });
    test('Create order fails 3', () async {
      const userUid = '13';
      OrderController orderController = OrderController();
      CartController cartController = CartController();

      FakeUser fakeUser = new FakeUser();
      UserModel user = new UserModel(
        uid: userUid,
        email: fakeUser.email,
        displayName: fakeUser.displayName,
        photoUrl: fakeUser.photoUrl,
      );

      db.collection('users').doc(userUid).set(user.toJson());

      DocumentReference userDoc = db.collection('users').doc(userUid);

      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product_1 = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      CartItemModel cartItem_1 = new CartItemModel(
        product: product_1,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 2,
      );

      cartItems.add(cartItem_1);

      await cartController.newProduct(userDoc, cartItems[0]);

      String customerName = '';
      String customerDoc = '';
      String address = '';
      num amount = await orderController.calcAmount(userDoc);

      await orderController
          .newOrder(userDoc, customerName, customerDoc, address, amount)
          .catchError((e) {
        expect(e.message, 'Campos incompletos');
      });
    });
  });
}

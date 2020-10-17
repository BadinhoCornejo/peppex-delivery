import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:peppex_delivery/models/models.dart';
import 'package:peppex_delivery/ui/screens/screens.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rx<User> userSnapshot = Rx<User>();
  Rx<UserModel> userModel = Rx<UserModel>();

  @override
  void onReady() async {
    //run every time auth state changes
    ever(userSnapshot, handleAuthChanged);
    userSnapshot.value = await getUser;
    userSnapshot.bindStream(user);
    super.onInit();
  }

  @override
  void onClose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  handleAuthChanged(_userSnapshot) async {
    if (_userSnapshot?.uid != null) {
      userModel.bindStream(streamFirestoreUser());
    }

    if (_userSnapshot == null) {
      Get.offAll(Login());
    } else {
      Get.offAll(Home());
    }
  }

  Future<User> get getUser async => _auth.currentUser;

  Stream<User> get user => _auth.authStateChanges();

  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');
    if (userSnapshot?.value?.uid != null) {
      return _db
          .doc('/users/${userSnapshot.value.uid}')
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data()));
    }

    return null;
  }

  Future<UserModel> getFirestoreUser() {
    if (userSnapshot?.value?.uid != null) {
      return _db.doc('/users/${userSnapshot.value.uid}').get().then(
          (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()));
    }
    return null;
  }

  signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
    } catch (error) {
      Get.snackbar(
        'Error al iniciar sesión',
        'Email o contraseña incorrectos.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      UserCredential _credential = await _auth.signInWithCredential(credential);
      DocumentSnapshot _snapshot =
          await _db.collection('uses').doc(_credential.user.uid).get();

      if (!_snapshot.exists) {
        User _userSnapshot = await getUser;
        UserModel _newUser = _createUserModel(_userSnapshot);

        _createUserFirestore(_newUser, _userSnapshot);
      }
    } catch (error) {
      print(error);
      Get.snackbar(
        'Hubo un error al iniciar sesión',
        'Por favor, intente nuevamente',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  registerWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      UserModel _newUser =
          _createUserModel(credential.user, displayName: nameController.text);

      _createUserFirestore(_newUser, credential.user);
      emailController.clear();
      passwordController.clear();
    } catch (error) {
      Get.snackbar(
        'Hubo un error al registrarse',
        'Por favor, intente nuevamente',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  Future<void> signOut() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
  }

  UserModel _createUserModel(User user, {String displayName: ''}) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: displayName == '' ? user.displayName : displayName,
      photoUrl: user.photoURL,
    );
  }
}

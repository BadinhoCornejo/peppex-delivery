import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:peppex_delivery/models/models.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rx<User> _user = Rx<User>();

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
  }

  @override
  void onClose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  String get user => _user.value?.uid;

  Future<User> get getUser async => _auth.currentUser;

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

  signInAsGuest(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {
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

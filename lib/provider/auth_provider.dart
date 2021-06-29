import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore

enum AuthMode { login, signup }

class Auth with ChangeNotifier {
  AuthMode _authMode = AuthMode.login;
  bool _isLogin = true;

  AuthMode get authMode => _authMode;
  bool get isLogin => _isLogin;
  set authMode(AuthMode authMode) {
    this._authMode = authMode;
    this._isLogin = _authMode == AuthMode.login ? true : false;
    notifyListeners();
  }

  // final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream<auth.User> get onAuthStateChanged => _auth.authStateChanges();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String _userId;
  String get userId => _userId;
  set userId(userId) => _userId = userId;

  // Future<String> login(String email, String password) async {
  //   String errMessage;

  //   _isLoading = true;
  //   notifyListeners();
  //   {
  //     await _auth
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .then(_writeUserAuthData)
  //         .catchError((err) => errMessage = _catchLoginError(err));
  //   }
  //   _isLoading = false;
  //   notifyListeners();

  //   return errMessage;
  // }

  // Future<String> signup(String email, String password, String name) async {
  //   String errMessage;

  //   _isLoading = true;
  //   notifyListeners();
  //   {
  //     await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //         .then(_writeUserAuthData)
  //         .catchError((err) => errMessage = _catchSignupError(err));

  //     // await _firestore.collection('Users').doc(this._userId).set(
  //     //     Map<String, dynamic>.from(
  //     //         Profile(email: email, name: name, walkthrough: true).toJson()));
  //   }
  //   _isLoading = false;
  //   notifyListeners();

  //   return errMessage;
  // }

  // Future<void> _writeUserAuthData(auth.UserCredential authResult) async {
  //   _userId = authResult.user.uid;
  // }

  // Future<void> logout() async {
  //   _auth.signOut();
  // }

  String _catchLoginError(PlatformException err) {
    switch (err.code) {
      case "ERROR_INVALIED_EMAIL":
        return "The email address is invalied, try using a different address.";
      case "ERROR_WRONG_PASSWORD":
        return "Incorrect email or password.";
      case "ERROR_USER_NOT_FOUND":
        return "This email address is not connected to an account. Signup?";
      case "ERROR_USER_DISABLED":
        return "This user is disabled. Try contacting support.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Please try again later.";
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "ENABLE AUTH IN FIREBASE, NUCKLEHEAD!";
      default:
        return "Ouh ouh, new error! $err";
    }
  }

  String _catchSignupError(PlatformException err) {
    switch (err.toString()) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "This email address is already connected to an account. Forgot password?";
      case "ERROR_INVALIED_EMAIL":
        return "The email address is invalied, try using a different address.";
      case "ERROR_WEAK_PASSWORD":
        return "The password is weak, try using a stronger one.";
      default:
        return "Ouh ouh, new error! $err";
    }
  }
}

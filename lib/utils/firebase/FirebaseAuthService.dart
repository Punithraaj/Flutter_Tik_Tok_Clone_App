import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class BaseAuth {
  Future<User> getCurrentUser();
  Future<bool> signIn(String email, String password);
  Future<bool> createUser(String userName, String email, String password);
  Future<void> signOut();
}

class FirebaseAuthService implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

// Collection refs
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  Future<bool> signIn(String email, String password) async {
    User user = (await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .onError((error, stackTrace) {
      throw "Error ${error.toString()}";
    }))
        .user!;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> createUser(
      String userName, String email, String password) async {
    User user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user!;

    if (user != null) {
      await saveUserToFirestore(userName, user.uid, email);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<User> getCurrentUser() async {
    User user = await _firebaseAuth.currentUser!;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  saveUserToFirestore(String name, String userId, String email) async {
    await usersRef.doc(userId).set({
      'username': name,
      'email': email,
      'id': userId,
    });
  }

  String handleFirebaseAuthError(String e) {
    if (e.contains("ERROR_WEAK_PASSWORD")) {
      return "Password is too weak";
    } else if (e.contains("invalid-email")) {
      return "Invalid Email";
    } else if (e.contains("ERROR_EMAIL_ALREADY_IN_USE") ||
        e.contains('email-already-in-use')) {
      return "The email address is already in use by another account.";
    } else if (e.contains("ERROR_NETWORK_REQUEST_FAILED")) {
      return "Network error occured!";
    } else if (e.contains("ERROR_USER_NOT_FOUND") ||
        e.contains('firebase_auth/user-not-found')) {
      return "Invalid credentials.";
    } else if (e.contains("ERROR_WRONG_PASSWORD") ||
        e.contains('wrong-password')) {
      return "Invalid credentials.";
    } else if (e.contains('firebase_auth/requires-recent-login')) {
      return 'This operation is sensitive and requires recent authentication.'
          ' Log in again before retrying this request.';
    } else {
      return e;
    }
  }

  forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

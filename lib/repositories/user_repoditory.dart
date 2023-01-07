import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
  UserRepository({required this.firebaseAuth});

  // Sign Up with email and password

  Future<User?> signUp(String email, String password) async {
    try {
      print('reg1 $email');
      var auth = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('reg $email');
      return auth.user!;
    } catch (e) {
      print('error reg ${e.toString()}');
    }
    return null;
  }

  // Sign In with email and password

  Future<User?> signIn(String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Sign Out

  Future<void> signOut() async {
    print('signou ${isSignedIn()}');
    await firebaseAuth.signOut();
  }

  // check Sign In
  bool isSignedIn() {
    var currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  //get current user

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}

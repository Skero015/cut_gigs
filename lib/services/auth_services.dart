import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_gigs/models/User.dart';
import 'package:cut_gigs/screens/auth_screens/LoginScreen.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn googleSignIn = GoogleSignIn();


//Sign out
  Future signOut() async {
    return  _auth.signOut();
  }

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid,name: user.displayName) : null;
  }

//Auth changes user stream
  Stream<UserModel> get user {
    return _auth.authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));

  }

//Get current user
  Future<String> currentUser() async {
    try {
      User currentUser = FirebaseAuth.instance.currentUser;
      return currentUser.uid;
    } catch (e) {
      return null;
    }
  }

//Sign in
  Future signIn(String email, String password) async {
    UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    print(result);
    print(result.user);
//Checking if user is varified
    if (user.emailVerified){ return _userFromFirebaseUser(user);}
    else{return null;}

  }


  Future updatephone(String phone, String user) async{
    await DatabaseService(uid: user).addUserphone(phone);
  }


//Sign Up
  Future signUp(String email, String password, String phoneNumber, String name, String surname,String title, String country, context) async {

    UserCredential result;
    User user;

    result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    print('setting user..');
    user = result.user;
    print('user set');
    //updating diplay name
    FirebaseAuth.instance.currentUser.updateProfile(displayName: name);

    await user.sendEmailVerification();

//    Adding User to Database
    await DatabaseService(uid: user.uid).addUserData(name,surname, phoneNumber,email,title, country);

    if (result != null) {
      _auth.signOut();
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new LoginScreen(reason: "verify email",)));
    }

  }

//Forgot password
  Future forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }


  Future deleteUser() async {
    //  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();


    //     await _auth.signOut();
    //     await DatabaseService(uid: currentUser.uid).deleteUser();
    //      await Address(uid: currentUser.uid).deleteUserAddress();
  }


  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.code) {
        case 'ERROR_USER_NOT_FOUND':
          return 'User with this email address not found.';
          break;
        case 'ERROR_WRONG_PASSWORD':
          return 'Invalid password.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          return 'No internet connection or too many requests. Try again later.';
          break;
        case "ERROR_INVALID_EMAIL":
          return "Your email is invalid";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          return 'This email address already has an account.';
          break;
        case "ERROR_USER_DISABLED":
          return "User with this email has been disabled. Please contact support.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          return "Anonymous accounts are not enabled";
          break;
        default:
          return 'Make sure you have a stable connection and try again.';
      }
    } else if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'ERROR_USER_NOT_FOUND':
          return 'User with this email address not found.';
          break;
        case 'ERROR_WRONG_PASSWORD':
          return 'Invalid password.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          return 'No internet connection or too many requests. Try again later.';
          break;
        case "ERROR_INVALID_EMAIL":
          return "Your email is invalid";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          return 'This email address already has an account.';
          break;
        case "ERROR_USER_DISABLED":
          return "User with this email has been disabled. Please contact support.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          return "Anonymous accounts are not enabled";
          break;
        default:
          return 'Make sure you have a stable connection and try again.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
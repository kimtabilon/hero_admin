import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
          (User user) => user?.uid);

  //Get UID
  Future getCurrentUID() async{
    return (await _firebaseAuth.currentUser).uid;
  }


  // Email & Password Sign Up
  Future createUserWithEmailAndPassword(String email,String password) async{
    final currentUser = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password)).user.uid;
    return currentUser;
  }

  // Email & Password Sign In
  Future signInWithEmailAndPassword(String email, String password) async{
    UserCredential result =await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  //Sign Out
  signOut(){
    return _firebaseAuth.signOut();
  }

  //Reset Password

  Future sendPasswordResetEmail(String email) async{
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Check if user exist

  Future doesNameAlreadyExist(String email,String fname,String lname, String mobile) async {
    // final result = await FirebaseFirestore.instance
    //     .collection('userData')
    //     .doc(id)
    //     .collection('Profile')
    //     .where('Email', isEqualTo: email.toLowerCase())
    //     .limit(1)
    //     .get();
    // final List<DocumentSnapshot> documents = result.docs;

    final result_2 = await FirebaseFirestore.instance
        .collection('profile')
        .where('first_name', isEqualTo: fname.toLowerCase())
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents_2 = result_2.docs;

    final result_3 = await FirebaseFirestore.instance
        .collection('profile')
        .where('last_name', isEqualTo: lname.toLowerCase())
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents_3 = result_3.docs;

    final result_4 = await FirebaseFirestore.instance
        .collection('contact')
        .where('value', isEqualTo: mobile)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents_4 = result_4.docs;

    //return result;

    // else if(documents_2.length == 1 && documents_3.length == 1){
    //   return "Name already Exist";
    // }
    if(documents_4.length == 1){
      return "Mobile Number already Exist.";
    } else{
      return null;
    }
  }
}


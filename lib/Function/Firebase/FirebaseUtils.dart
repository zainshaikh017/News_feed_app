import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_feed_app/Auth/Login.dart';
import 'package:news_feed_app/View/HomeScreen.dart';

import '../../session_controller/session_controller.dart';

class FirebaseUtils {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to register a new user
  Future<void> signUp({required BuildContext context,required String email, required String password,required String phone,required String username}) async {

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password).then((value) {
        sessionControlar().userid=value.user!.uid.toString();
        _firestore.collection('users').doc(value.user!.uid.toString()).set({
          'uid' :value.user!.uid.toString(),
          'email':value.user!.email.toString(),
          'phone': phone ,
          'username': username,
        });
        // Navigator.pop(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return HomeScreen();
        },));
      });
    } catch (e) {
      // setloading(false);
      print('Error in signUp: $e');
    }
  }

  // Function to log in an existing user
  Future<void> login({required BuildContext context ,required String email, required String password})async {
    // setloading(true);
    try{
      _auth.signInWithEmailAndPassword(email: email, password: password).then((value){
        FirebaseAuth auth=FirebaseAuth.instance;
        final user= auth.currentUser;

        sessionControlar().userid=user!.uid.toString();
        // setloading(false);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return HomeScreen();
        },));

      });

    }catch(e){
      // setloading(false);
    }
  }

  // Function to sign out the current user

  Future<void> signout(BuildContext context)async{

    FirebaseAuth.instance.signOut().then((value){
      sessionControlar().userid="null";
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const Login();
      },));
    }

    );
  }


  // Function to post data to Firestore
  Future<void> postData(String userId, String data) async {
    try {
      await _firestore.collection('posts').add({
        'userId': userId,
        'data': data,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error in postData: $e');
    }
  }
}



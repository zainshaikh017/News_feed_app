// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_feed_app/Auth/Login.dart';
import 'package:news_feed_app/View/HomeScreen.dart';
import '../session_controller/session_controller.dart';

class splash_services{

  void islogin(BuildContext context){
    FirebaseAuth auth=FirebaseAuth.instance;
    final user= auth.currentUser;

    if(user != null){
      sessionControlar().userid=user.uid.toString();


        Timer(const Duration(seconds:3),()=>
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            },))
        );


    }
    else{
      Timer(const Duration(seconds:3),()=>
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return const Login();
          },))
      );
    }
  }

}
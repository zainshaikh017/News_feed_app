import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_feed_app/splash_service/splash_service.dart';

import '../../Auth/Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash_services().islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Image.asset('assets/logo.png'),
      ),


    );
  }
}

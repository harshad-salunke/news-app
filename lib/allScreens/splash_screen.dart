import 'dart:ui';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/allScreens/main_screen.dart';
import 'package:newsapp/services/providers/news_providers.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import 'login_screens/login_screen.dart';



class SplashScreen extends StatefulWidget {
  static final String routePath = '/splashscreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  @override
  void initState() {
    if(firebaseAuth.currentUser?.uid!=null){

      Provider.of<NewsProvider>(context,listen: false).fetchUserDetails();
      Provider.of<NewsProvider>(context,listen: false).fetchHomeNews();
      Provider.of<NewsProvider>(context,listen: false).fetchLovedArticle();
      Provider.of<NewsProvider>(context,listen: false).fetchReadingArticle();


    }else{
      print('user not login');
    }
    super.initState();
    Timer(Duration(seconds: 3), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyAppColor.status_bar_color,
      ));

      if(firebaseAuth.currentUser?.uid!=null){
        Navigator.pushReplacementNamed(context, MainScreen.routePath);
      }else{
        Navigator.pushReplacementNamed(context, LoginScreen.routePath);
      }

    });
  }

  @override
  void dispose( ) {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set the status bar color to transparent
    ));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [


          Image(
            image: AssetImage('assets/images/logo.png'),
            height: 200,
            width: 200,
          ),
          Text(
            'News App',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'Brand-Bold',
              fontWeight: FontWeight.bold,
            ),
          ),





        ],
      ),
    );
  }
}

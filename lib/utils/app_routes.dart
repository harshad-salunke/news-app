import 'package:flutter/cupertino.dart';
import 'package:newsapp/allScreens/news_details_screen.dart';

import '../allScreens/login_screens/login_screen.dart';
import '../allScreens/login_screens/register_screen.dart';
import '../allScreens/main_screen.dart';
import '../allScreens/profile_related_screens/notification_screen.dart';
import '../allScreens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> getAppRoutes(){
  Map<String, Widget Function(BuildContext)> appRoutes={

    MainScreen.routePath:(context)=>const MainScreen(),
    NewsDetailsScreen.routePath:(context)=>const NewsDetailsScreen(),
    LoginScreen.routePath:(context)=>LoginScreen(),
    RegisterScreen.routePath:(context)=>RegisterScreen(),
    SplashScreen.routePath:(context)=>const SplashScreen(),
    NotificationScreen.routePath:(context)=>NotificationScreen()


  };

  return appRoutes;
}
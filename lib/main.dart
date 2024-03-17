import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/allScreens/main_screen.dart';
import 'package:newsapp/services/providers/firbase_auth_handler.dart';
import 'package:newsapp/services/providers/news_providers.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:newsapp/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'allScreens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsProvider()),
        ChangeNotifierProvider(create: (context) => FirebaseAuthHandler()),

      ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: MyAppColor.primary_color),
            useMaterial3: true,
        ),
        initialRoute: SplashScreen.routePath,
        routes: getAppRoutes(),
      ),
    );
  }
}


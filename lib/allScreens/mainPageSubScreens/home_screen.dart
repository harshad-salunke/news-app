
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/home_page/categories_navbar.dart';
import '../../widgets/home_page/navigation_drawer.dart';
import '../../widgets/home_page/news_section.dart';
import '../profile_related_screens/notification_screen.dart';
import '../splash_screen.dart';



class HomeScreen extends StatefulWidget {



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Color(0xfff7f7f7),

      drawer: const MyNavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        scrolledUnderElevation:0,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),

            Text('News App',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
            Expanded(child: Container()),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, NotificationScreen.routePath);
                },
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                )),
          ],
        ),
        centerTitle: true,
      ),

      body: Container(
        child: Column(
          children: [
            CategoriesNavBar(),

           Expanded(child:  NewsSection())
          ],
        ),
      ),
    );
  }
}

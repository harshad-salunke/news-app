import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/services/providers/news_providers.dart';
import 'package:provider/provider.dart';

import 'drawer_item.dart';


class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (_,newsProviders,__){
      return Drawer(
        child: Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 30, 24, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  headerWidget(newsProviders),
                  const SizedBox(height: 20,),
                  const Divider(thickness: 1, height: 10, color: Colors.grey,),
                  const SizedBox(height: 40,),
                  DrawerItem(
                    name: 'Personal Details',
                    icon: Icons.people,
                    onPressed: ()=> onItemPressed(context, index: 0),
                  ),
                  const SizedBox(height: 30,),
                  DrawerItem(
                      name: 'Following Authors',
                      icon: Icons.emoji_emotions_outlined,
                      onPressed: ()=> onItemPressed(context, index: 1)
                  ),
                  const SizedBox(height: 30,),

                  DrawerItem(
                      name: 'Most Loved',
                      icon: Icons.favorite,
                      onPressed: ()=> onItemPressed(context, index: 2)
                  ),
                  const SizedBox(height: 30,),

                  const Divider(thickness: 1, height: 10, color: Colors.grey,),
                  const SizedBox(height: 30,),

                  DrawerItem(
                      name: 'Log out',
                      icon: Icons.logout,
                      onPressed: ()=> onItemPressed(context, index: 3)
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void onItemPressed(BuildContext context, {required int index}){
    Navigator.pop(context);

    switch(index){
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }


  Widget headerWidget(NewsProvider newsProvider) {
    return Row(
      children: [
         CircleAvatar(
          radius: 40,
          backgroundColor:Color(0xfff1f1f1),
          backgroundImage:AssetImage(newsProvider.userData.gender=='Male'?"assets/images/college_boy.png":"assets/images/college_girl.png"),
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text('${getName('${newsProvider.userData.name}')}', style: TextStyle(
                fontSize: 18, color: Colors.black,
              fontFamily: 'Brand-bold'
            )),
            SizedBox(height: 5,),
            Text('${getTimeOfDay()}', style: TextStyle(fontSize: 14, color: Colors.black))
          ],
        )
      ],
    );

  }
  String getTimeOfDay() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now); // format the time as HH:mm
    int hour = int.parse(formattedTime.split(":")[0]); // extract the hour from the formatted time
    if (hour >= 5 && hour < 12) {
      return "Good Morning"; // between 5am and 12pm
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon"; // between 12pm and 5pm
    } else {
      return "Good Evening"; // after 5pm
    }
  }

  String getName(String name) {
    List<String> fullname= name.split(' ');
    if(name.length>15){
      return fullname[0];
    }
    return name;

  }



}
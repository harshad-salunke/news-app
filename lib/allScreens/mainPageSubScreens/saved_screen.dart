import 'package:flutter/material.dart';
import 'package:newsapp/allScreens/savedPageSubScreens/recent_read_screen.dart';
import 'package:newsapp/widgets/saved_page/saved_navbar.dart';

import '../savedPageSubScreens/loved_news_screen.dart';
class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late  PageController pageController;
  int currentpage=0;
  @override
  void initState() {
    pageController=PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10,),

          SavedNavBar(
            callback: (index){
              pageController.jumpToPage(index);
            },
            current: currentpage,
          ),

          Expanded(
            child: PageView(
              controller:pageController,
              onPageChanged: (index){
                setState(() {
                  currentpage=index;
                });
              },
              children: [
                LovedNewsScreen(),
                RecentReadScreen()
              ],
            ),
          ),


        ],
      ),

    );
  }
}

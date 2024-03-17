
import 'package:flutter/material.dart';
import 'package:newsapp/services/providers/news_providers.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';

class CategoriesNavBar extends StatefulWidget {

  @override
  State<CategoriesNavBar> createState() => _CategoriesNavBarState();
}

class _CategoriesNavBarState extends State<CategoriesNavBar> {
  int current=0;
List<String> categoris=[
  "For you",
  "Business",
  "Entertainment",
  "General",
  "Health",
  "Science",
  "Sports",
  "Technology",
];
  @override
  Widget build(BuildContext context) {
    return  Consumer<NewsProvider>(builder: (_,newsProvider,__){
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              for(int i=0;i<categoris.length;i++)
                GestureDetector(
                  onTap: (){
                    current=i;
                    featchCategoryNews(newsProvider);
                    setState(() {
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:current==i?MyAppColor.primary_color:Colors.white,

                    ),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    margin: EdgeInsets.all(5),
                    child: Text('${categoris[i]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:current==i? Colors.white:MyAppColor.black_light,
                          fontSize: 14
                      ),

                    ),

                  ),
                ),

            ],
          ),
        ),
      );
    });

  }

  void featchCategoryNews(NewsProvider newsProvider) {
    String selectedCategory=categoris[current];
    selectedCategory=selectedCategory.toLowerCase();
    newsProvider.setEmptyArticleList();
    if(current==0){
      newsProvider.fetchHomeNews();
    }else{
      newsProvider.fetchTagBasedNews(selectedCategory);

    }

  }
}

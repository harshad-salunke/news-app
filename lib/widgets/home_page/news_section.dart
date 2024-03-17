import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/allScreens/news_details_screen.dart';
import 'package:newsapp/services/providers/news_providers.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:newsapp/widgets/home_page/list_view_news_card.dart';
import 'package:provider/provider.dart';

import '../global/my_brand_bold_text.dart';
import 'gird_view_news_card.dart';

class NewsSection extends StatefulWidget {
  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  bool isGridView = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (_, newsProvider, __) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 5, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyBoldText(
                      text: "Trending News",
                      fontsize: 18,
                      fontWeight: FontWeight.w700,
                      color: MyAppColor.primary_color),
                  InkWell(
                    onTap: () {
                      isGridView = !isGridView;
                      setState(() {});
                    },
                    child: Icon(
                      isGridView
                          ? Icons.format_list_bulleted_rounded
                          : Icons.grid_view_sharp,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            newsProvider.isNewsLoading
                ? Expanded(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
                : newsProvider.articleList.isEmpty
                    ? Expanded(
                        child: Center(
                        child: MyBoldText(
                            text: 'No news available',
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                            color: MyAppColor.black_light),
                      ))
                    : getNewsList(newsProvider),
          ],
        ),
      );
    });
  }

  Widget buildGridView(NewsProvider newsProvider) {
    return Expanded(
      child: Container(
          child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.660, // Adjust the aspect ratio as needed
        ),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: newsProvider.articleList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              newsProvider.setSelectedArticle(newsProvider.articleList[index]);
              Navigator.pushNamed(context, NewsDetailsScreen.routePath);
            },
            child: Container(child: GridViewNewsCard(article: newsProvider.articleList[index],)),
          );
        },
      )),
    );
  }

  buildListView(NewsProvider newsProvider) {
    return Expanded(
        child: Container(
            child: ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: newsProvider.articleList.length,
      itemBuilder: (BuildContext con, int index) {
        return InkWell(
          onTap: () {
            newsProvider.setSelectedArticle(newsProvider.articleList[index]);
            Navigator.pushNamed(context, NewsDetailsScreen.routePath);
          },
          child: ListViewNewsCard(article: newsProvider.articleList[index],),
        );
      },
    )));
  }

  Widget getNewsList(NewsProvider newsProvider) {
    return isGridView ? buildGridView(newsProvider) : buildListView(newsProvider);
  }

}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/providers/news_providers.dart';
import '../../utils/app_colors.dart';
import '../../widgets/global/my_brand_bold_text.dart';
import '../../widgets/home_page/list_view_news_card.dart';
import '../news_details_screen.dart';
class LovedNewsScreen extends StatefulWidget {
  const LovedNewsScreen({Key? key}) : super(key: key);

  @override
  State<LovedNewsScreen> createState() => _LovedNewsScreenState();
}

class _LovedNewsScreenState extends State<LovedNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder:(_,newsProvider,__){
      return Column(
        children: [
          newsProvider.isLovedArticleLoading
              ? Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ))
              : newsProvider.lovedArticleList.isEmpty
              ? Expanded(
              child: Center(
                child: MyBoldText(
                    text: 'Empty Loved Article Bucket',
                    fontsize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyAppColor.black_light),
              ))
              : buildListView(newsProvider),
        ],
      );
    });
  }

  buildListView(NewsProvider newsProvider) {
    return Expanded(
        child: Container(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: newsProvider.lovedArticleList.length,
              itemBuilder: (BuildContext con, int index) {
                return InkWell(
                  onTap: () {
                    newsProvider.setSelectedArticle(newsProvider.lovedArticleList[index]);
                    Navigator.pushNamed(context, NewsDetailsScreen.routePath);
                  },
                  child: ListViewNewsCard(article: newsProvider.lovedArticleList[index],),
                );
              },
            )));
  }

}

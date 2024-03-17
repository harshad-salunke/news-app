import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/utils/global_widgets.dart';
import 'package:provider/provider.dart';

import '../../services/providers/news_providers.dart';
import '../../utils/app_colors.dart';
import '../../widgets/global/my_brand_bold_text.dart';
import '../../widgets/home_page/list_view_news_card.dart';
import '../news_details_screen.dart';

class RecentReadScreen extends StatefulWidget {
  const RecentReadScreen({Key? key}) : super(key: key);

  @override
  State<RecentReadScreen> createState() => _RecentReadScreenState();
}

class _RecentReadScreenState extends State<RecentReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (_, newsProvider, __) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Recent Reading",
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    showProgressBar(context, 'Please Wait');
                    await newsProvider.clearRecentReading();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Clear all',
                    style: GoogleFonts.openSans(
                        fontSize: 13, color: MyAppColor.primary_color),
                  ),
                )
              ],
            ),
          ),
          newsProvider.isreadingArticleLoading
              ? Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : newsProvider.readingArticleList.isEmpty
                  ? Expanded(
                      child: Center(
                      child: MyBoldText(
                          text: 'Empty recent read article',
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
      itemCount: newsProvider.readingArticleList.length,
      itemBuilder: (BuildContext con, int index) {
        return InkWell(
          onTap: () {
            newsProvider
                .setSelectedArticle(newsProvider.readingArticleList[index]);
            Navigator.pushNamed(context, NewsDetailsScreen.routePath);
          },
          child: ListViewNewsCard(
            article: newsProvider.readingArticleList[index],
          ),
        );
      },
    )));
  }
}

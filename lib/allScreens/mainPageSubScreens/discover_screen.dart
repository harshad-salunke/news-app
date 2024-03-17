import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/services/providers/news_providers.dart';
import 'package:provider/provider.dart';

import '../../models/article_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/explore_page/filter_item.dart';
import '../../widgets/global/my_brand_bold_text.dart';
import '../../widgets/home_page/gird_view_news_card.dart';
import '../filter_screen/FilterScreen.dart';
import '../news_details_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<int> filterIndex = [-1, -1, -1];
  List<String> selectedFilterString = ['India'];
  List<Article> filterArticleList = [];
  late NewsProvider newsProvider;
  bool isSearchOn=false;
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false)
        .setEmptyFilterArticleList();
    Provider.of<NewsProvider>(context, listen: false)
        .fetchCountryBasedNews('in');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (_, newsProvider, __) {
      this.newsProvider=newsProvider;
      if(!isSearchOn){
        filterArticleList.clear();
        filterArticleList.addAll( newsProvider.filterList);
      }

      return SafeArea(
          child: Container(
              child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyBoldText(
                    text: 'Discover',
                    fontsize: 25,
                    fontWeight: FontWeight.w900,
                    color: MyAppColor.primary_color),
                MyBoldText(
                    text: 'news from all over the world',
                    fontsize: 13,
                    fontWeight: FontWeight.w700,
                    color: MyAppColor.black_light),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  onChanged: (text){
                    if(text.isNotEmpty){
                      isSearchOn=true;
                    }
                    filterArticleList.clear();
                    newsProvider.filterList.forEach((articles) {
                      String title=articles.title.toLowerCase();
                      if(title.contains(text.toLowerCase())){
                        filterArticleList.add(articles);
                      }
                    });

                    if(text=='' || text.isEmpty){
                      filterArticleList.addAll(newsProvider.filterList);
                      print(newsProvider.filterList.length);
                      isSearchOn=false;
                    }
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Search article...',

                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: MyAppColor.white_light)),
                      suffixIcon: InkWell(
                        onTap: () {
                          openFilterPage();
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: MyAppColor.primary_color,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: MyAppColor.white_light))),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < selectedFilterString.length; i++)
                        FilterItem(
                            text: selectedFilterString[i],
                            filter_option: i,
                            callback: (int index, String close) {
                              setState(() {
                                filterIndex[index] = -1;
                                selectedFilterString.removeAt(index);
                                if(selectedFilterString.isEmpty){
                                  filterIndex = [-1, -1, -1];
                                }
                                featchNewData();
                              });
                            })
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          newsProvider.isFilterNewsLoading
              ? Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : newsProvider.filterList.isEmpty
                  ? Expanded(
                      child: Center(
                      child: MyBoldText(
                          text: 'No news available',
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                          color: MyAppColor.black_light),
                    ))
                  : buildGridView(),
        ],
      )));
    });
  }

  void openFilterPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FilterScreen(
                  filterIndex: filterIndex,
                  filterApplyResult:
                      (List<String> filter, List<int> filterIndex) {
                    this.filterIndex = filterIndex;

                    applyFilterOnData(filter,);
                  },
                )));
  }

  void applyFilterOnData(List<String> filter) {
    selectedFilterString = filter;
    print(selectedFilterString);
    setState(() {});
    featchNewData();
  }

  getCountryCodeByName(String country) {
    Map<String, String> CountryMap = {
      'Argentina': 'AR',
      'Austria': 'AT',
      'Australia': 'AU',
      'Belgium': 'BE',
      'Bulgaria': 'BG',
      'Brazil': 'BR',
      'Canada': 'CA',
      'Switzerland': 'CH',
      'China': 'CN',
      'Colombia': 'CO',
      'Czech Republic': 'CZ',
      'Germany': 'DE',
      'Egypt': 'EG',
      'Spain': 'ES',
      'France': 'FR',
      'UK': 'GB',
      'Greece': 'GR',
      'Hong Kong': 'HK',
      'Hungary': 'HU',
      'Indonesia': 'ID',
      'Ireland': 'IE',
      'Israel': 'IL',
      'India': 'IN',
      'Italy': 'IT',
      'Japan': 'JP',
      'South Korea': 'KR',
      'Lithuania': 'LT',
      'Latvia': 'LV',
      'Mexico': 'MX',
      'Malaysia': 'MY',
      'Nigeria': 'NG',
      'Netherlands': 'NL',
      'New Zealand': 'NZ',
      'Philippines': 'PH',
      'Poland': 'PL',
      'Portugal': 'PT',
      'Romania': 'RO',
      'Serbia': 'RS',
      'Russia': 'RU',
      'Saudi Arabia': 'SA',
      'Sweden': 'SE',
      'Singapore': 'SG',
      'Slovakia': 'SK',
      'Thailand': 'TH',
      'Turkey': 'TR',
      'Taiwan': 'TW',
      'Ukraine': 'UA',
      'United States': 'US',
      'Venezuela': 'VE',
      'South Africa': 'ZA',
    };
    String countryCode = CountryMap[country]!;
    return countryCode.toLowerCase();
  }

  Widget buildGridView() {
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
        itemCount: filterArticleList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              newsProvider.setSelectedArticle(filterArticleList[index]);
              Navigator.pushNamed(context, NewsDetailsScreen.routePath);
            },
            child: Container(
                child: GridViewNewsCard(
              article: filterArticleList[index],
            )),
          );
        },
      )),
    );
  }

  void featchNewData() {
    newsProvider.setEmptyFilterArticleList();

    if(filterIndex[0]!=-1 && filterIndex[1]!=-1){
      String country=getCountryCodeByName(selectedFilterString[0]);
      String category=selectedFilterString[1];
      newsProvider.fetchCountryAndCategoryNews(category, country);

    }else if(filterIndex[0]!=-1){

      String country=getCountryCodeByName(selectedFilterString[0]);
      newsProvider.fetchCountryBasedNews(country);

    }else if(filterIndex[1]!=-1){

      String category=selectedFilterString[0];
      newsProvider.fetchCategoryBasedNews(category);

    }else{
      newsProvider.filterList=[];
      newsProvider.isFilterNewsLoading=false;
      newsProvider.notifyListeners();
    }
  }
}

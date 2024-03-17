import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/services/providers/news_providers.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:newsapp/utils/global_widgets.dart';
import 'package:newsapp/widgets/global/CircularIconButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/newsDetailPage/bottom_text_adjust.dart';

class NewsDetailsScreen extends StatefulWidget {
  static String routePath = "newsDetailsScreen";

  const NewsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isDarkModeOn = false;
  bool isLoved = false;
  double textSize = 12; // Default text size
  String auther_defaultImage='https://clipart-library.com/data_images/100613.png';

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder:(_,newsProvider,__){
      Article selectedArticel=newsProvider.selectedArtical;
      return Scaffold(
        appBar: AppBar(
          leading: CircularIconButton(
              index: 0,
              icon: Icons.arrow_back_outlined,
              bgcolor:isDarkModeOn? MyAppColor.black_light:MyAppColor.white_light,
              iconColor:isDarkModeOn?Colors.white: Colors.black,
              height: 45,
              width: 45,
              iconsize: 25,
              callback: (int index) {
                Navigator.pop(context);
              }),
          scrolledUnderElevation: 0,
          title: BuildAppBar(),
          backgroundColor: isDarkModeOn ? Colors.black :  Color(0xfff7f7f7),
        ),
        backgroundColor: isDarkModeOn ? Colors.black :  Color(0xfff7f7f7),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${getFormatedDate(selectedArticel.publishedAt)}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDarkModeOn
                                ? MyAppColor.white_light
                                : MyAppColor.black_light),
                      ),
                      Card(
                        color: isDarkModeOn ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ClipRRect(

                          borderRadius: BorderRadius.circular(15.0),
                          child: CachedNetworkImage(
                            imageUrl: selectedArticel.urlToImage,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Center(
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(value: downloadProgress.progress)),
                                ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/full_logo.png", // Replace with your loading image
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                            fit: BoxFit.cover,
                            height: 200,

                            width: double.infinity,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              '${selectedArticel.title}',

                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  color: isDarkModeOn?Colors.white: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize:textSize+3),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async{
                              showProgressBar(context, 'Please wait');
                              Article lovedArticle=newsProvider.selectedArtical;
                              await newsProvider.savedLovedArticle(lovedArticle);
                              Navigator.pop(context);
                              isLoved = !isLoved;
                              showToast("Successfully Mark As Loved ...!", ContentType.success,context);

                              setState(() {});
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: MyAppColor.white_light),
                              child: Icon(
                                Icons.favorite,
                                color: isLoved ? Colors.red : Colors.black26,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color:  MyAppColor.white_light ,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(auther_defaultImage),
                            radius: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${getText(selectedArticel.author)}",
                                  style: GoogleFonts.roboto(
                                    color: isDarkModeOn?Colors.white: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  )),
                              Text("Author",
                                  style: GoogleFonts.roboto(
                                    color: isDarkModeOn?MyAppColor.white_light: MyAppColor.black_light,

                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                          Expanded(child: Container()),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(30, 30),
                              backgroundColor: isDarkModeOn?Colors.black:Colors.white,
                              side: BorderSide(
                                  color:isDarkModeOn?Colors.white: MyAppColor.black_light
                              ), // Border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                color: isDarkModeOn?Colors.white: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Brand-Bold",
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color:  MyAppColor.white_light,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          '${selectedArticel.description}',
                          style: TextStyle(
                            fontSize: textSize,
                            color: isDarkModeOn?MyAppColor.white_light:MyAppColor.black_light,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  showTextSizeBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomTextAdjust(
          fontSize: textSize,
          fontChange: (double font){
            textSize=font;
            setState(() {

            });
          },
        );
      },
    );
  }

  BuildAppBar() {
    return Container(
      child: Row(
        children: [
          Expanded(child: Container()),
          CircularIconButton(
              index: 0,
              icon: Icons.abc,
              bgcolor:isDarkModeOn? MyAppColor.black_light:MyAppColor.white_light,
              iconColor:isDarkModeOn?Colors.white: Colors.black,
              height: 45,
              width: 45,
              iconsize: 25,
              callback: (int index) {
                showTextSizeBottomSheet();
              }),
          SizedBox(
            width: 10,
          ),
          CircularIconButton(
              index: 0,
              icon: isDarkModeOn ? Icons.light_mode : Icons.dark_mode,
              bgcolor:isDarkModeOn? MyAppColor.black_light:MyAppColor.white_light,
              iconColor: isDarkModeOn ? MyAppColor.yellow : Colors.black,
              height: 45,
              width: 45,
              iconsize: 25,
              callback: (int index) {
                setState(() {
                  isDarkModeOn = !isDarkModeOn;
                });
              }),
          SizedBox(
            width: 10,
          ),
          CircularIconButton(
              index: 0,
              icon: Icons.share,
              bgcolor:isDarkModeOn? MyAppColor.black_light:MyAppColor.white_light,
              iconColor:isDarkModeOn?Colors.white: Colors.black,
              height: 45,
              width: 45,
              iconsize: 20,
              callback: (int index) {
                print(index);
              }),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
  String getText(String author) {
    if(author.length>25){
      return author.substring(0,25);
    }
    return author;
  }

}

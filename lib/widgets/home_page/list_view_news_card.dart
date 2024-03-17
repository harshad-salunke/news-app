import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:newsapp/utils/global_widgets.dart';
import 'package:newsapp/widgets/global/my_brand_bold_text.dart';


class ListViewNewsCard extends StatelessWidget {
  Article article;
  ListViewNewsCard({required this.article});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 4, 10, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage,
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
                      height: 120,
                      width: 120,

                    ),
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                  ),
                ),
              ),

              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    MyBoldText(text: '${article.author}', fontsize: 12, fontWeight: FontWeight.bold, color: Colors.red),
                    Text(
                      '${getText(article.title)}',
                      style: GoogleFonts.openSans(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text(
                          '${getFormatedDate(article.publishedAt)}',
                          style: TextStyle(
                            color: MyAppColor.black_light,
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50)
                          ),
                        ),
                        SizedBox(width: 5,),

                        Text(
                          '4 min read',
                          style: TextStyle(
                              color: MyAppColor.black_light,
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
         
        ],
      ),
    );
  }
  getText(String news) {
    if(news.length>70){
      return news.substring(0,70);
    }
    return news;

  }

}

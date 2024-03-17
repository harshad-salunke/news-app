import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:newsapp/widgets/global/my_brand_bold_text.dart';

class GridViewNewsCard extends StatefulWidget {
  Article article;
   GridViewNewsCard({required this.article});

  @override
  State<GridViewNewsCard> createState() => _GridViewNewsCardState();
}

class _GridViewNewsCardState extends State<GridViewNewsCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
crossAxisAlignment:CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.article.urlToImage,
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
                      width: double.infinity,
                    ),
                    fit: BoxFit.cover,
                    height: 120,

                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: Text('${getText(widget.article.title)}',
                  style: TextStyle(
                      fontFamily: 'Brand-Bold',
                      fontSize: 14,
                      fontWeight: FontWeight.bold

                  ),),
              ),
            ],
          ),
          Column(

            children: [

              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/Heart Icon_2.svg",
                            colorFilter: ColorFilter.mode(
                                Colors.black26,
                                BlendMode.srcIn),
                            height: 16,
                          ),
                        ),
                        SizedBox(width: 4,),
                        Text('12k',style: TextStyle(
                            fontSize: 14
                        ),)


                      ],
                    ),

                    getCardIcons((){

                    },'50',Icons.comment),
                    getCardIcons((){

                    },'7k',Icons.remove_red_eye_outlined)
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
  Widget getCardIcons(Function onclick,String text,IconData iconData){
    return Container(
      child: Row(
        children: [
          Icon(iconData,size: 20,
            color:  Colors.black26  ),
          SizedBox(width: 4,),
          Text('${text}',style: TextStyle(
            fontSize: 14
          ),)
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

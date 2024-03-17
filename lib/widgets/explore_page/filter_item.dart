import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class FilterItem extends StatelessWidget {
  String text;
  int filter_option;
  Function (int,String) callback;
   FilterItem({required this.text,required this.filter_option,required this.callback}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color:MyAppColor.primary_color,
      ),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      margin: EdgeInsets.all(5),
      child: Row(
        children: [
          Text('${text}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color:Colors.white,
                fontSize: 14
            ),
          
          ),
          SizedBox(width: 5,),
          InkWell(
            onTap: (){
              callback(filter_option,text);
            },
            child: Container(
              decoration: BoxDecoration(
                color: MyAppColor.white_light,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Icon(Icons.close,color:MyAppColor.primary_color,size: 18,),
            ),
          )
        ],
      ),

    );
  }
}

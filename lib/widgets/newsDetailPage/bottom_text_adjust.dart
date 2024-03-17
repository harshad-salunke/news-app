import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/widgets/global/my_brand_bold_text.dart';
class BottomTextAdjust extends StatefulWidget {
Function(double) fontChange;
double fontSize;
   BottomTextAdjust({required this.fontChange,required this.fontSize}) ;

  @override
  State<BottomTextAdjust> createState() => _BottomTextAdjustState();
}

class _BottomTextAdjustState extends State<BottomTextAdjust> {
  double textSize=12;
  bool isFirstTime=true;
  @override
  Widget build(BuildContext context) {
    if(isFirstTime){
      textSize=widget.fontSize;
      isFirstTime=false;
    }
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            child: Expanded(child: Center(child: Container(
              width: 35,
              height: 2,
              color: Colors.black,
            ),)),
          ),
          Text(
            'Font Size',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                  child: MyBoldText(text: 'A', fontsize: 14, fontWeight: FontWeight.w900, color:Colors.black)),
              Container(
                margin: EdgeInsets.only(right: 20),
                  child: MyBoldText(text: 'A', fontsize: 18, fontWeight: FontWeight.w900, color:Colors.black))

            ],
          ),
          Slider(
            value: textSize,
            min: 8,
            max: 24,

            onChanged: (value) {
              setState(() {
                textSize = value;
              });
              widget.fontChange(value);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  IconData icon;
  Color bgcolor;
  Color iconColor;
  int index;
  double height;
  double width;
  double iconsize;
  Function(int) callback;
  CircularIconButton({required this.index,
    required this.icon,required
    this.bgcolor,
    required this.iconColor,
    required this.height,
    required this.width,
    required this.iconsize,
    required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: bgcolor,

          ),
          child: GestureDetector(
            onTap: (){
              callback(index);
            },
            child: Icon(
                icon,
              color: iconColor,
              size: iconsize,
            ),
          ),

        ),

      ],
    );
  }
}
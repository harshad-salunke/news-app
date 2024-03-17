import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
class ProgressDialog extends StatelessWidget {
  String text;
   ProgressDialog({required this.text}) ;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,

      child: Container(
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              width: 20,
                height: 20,
                margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: 
            CircularProgressIndicator()),
            SizedBox(width: 5,),
            Text(
              '${text} . .',
              style: GoogleFonts.ubuntu(
                color:MyAppColor.golden_color,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),


          ],
        ),
      ),
    );
  }
}

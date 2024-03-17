

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../widgets/global/progress_dialog.dart';
import 'package:intl/intl.dart';


SnackBar getMySnackBar(String title,String msg,ContentType contentType){
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: msg,
      contentType: contentType,
    ),
  );
  return snackBar;
}

void showToast(String discription, ContentType contentType,BuildContext context) async {
  final snackBar = getMySnackBar('Hii , there!', discription, contentType);

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showProgressBar(BuildContext context,String title){
  showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return ProgressDialog(text: title,);
      });
}

String getFormatedDate(String date){
  DateTime originalDate = DateTime.parse(date);

  String formattedDate = DateFormat('dd MMM yyyy').format(originalDate);
  return formattedDate;
}


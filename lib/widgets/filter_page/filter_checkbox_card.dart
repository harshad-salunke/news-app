import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
class FilterCheckBoxCard extends StatelessWidget {
  String text;
  bool isSelected;
  int id;
  Function(int id) callback;
  FilterCheckBoxCard({
    required this.isSelected,
    required this.id,
    required this.callback,
    required this.text});

  @override
  Widget build(BuildContext context) {
   return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: MyAppColor.white_light)
          ),
      ),
      child: CheckboxListTile(
          value: isSelected,
          title: Row(
            children: [
              Text(text,
                style: TextStyle(
                    fontSize: 15,
                    color:isSelected? MyAppColor.primary_color:MyAppColor.black_light,
                    fontWeight: FontWeight.bold),
              ),

            ],
          ),
          onChanged: (vale) {
            callback(id);

          }),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';

class SavedNavBar extends StatefulWidget {
  Function(int) callback;
  int current;
  SavedNavBar({required this.callback,required this.current});

  @override
  State<SavedNavBar> createState() => _SavedNavBarState();
}

class _SavedNavBarState extends State<SavedNavBar> {
  int current=0;

  @override
  Widget build(BuildContext context) {
    current=widget.current;
    return  Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  current=0;
                  widget.callback(current);

                });

              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color:current==0? MyAppColor.primary_color: Colors.white,

                ),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            current==0? Colors.white:MyAppColor.black_light,
                            BlendMode.srcIn),
                        height: 16,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("You Loved",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:current==0? Colors.white:MyAppColor.black_light,
                          fontSize: 14
                      ),

                    )
                  ],
                ),

              ),
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  current=1;
                  widget.callback(current);

                });

              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color:current==1? MyAppColor.primary_color:Colors.white,

                ),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time_rounded,
                      size: 20,
                      color:current==1? Colors.white:MyAppColor.black_light,

                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Reading History",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:current==1? Colors.white:MyAppColor.black_light,
                          fontSize: 14
                      ),

                    )
                  ],
                ),

              ),
            ),
          ),

        ],
      ),
    );

  }
}

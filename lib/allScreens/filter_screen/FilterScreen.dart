import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/filter_page/FilterOptionList.dart';
import '../../widgets/global/my_brand_bold_text.dart';
import '../../widgets/global/my_elevated_button.dart';
class FilterScreen extends StatefulWidget {
  Function(List<String>,List<int>) filterApplyResult;
  List<int> filterIndex;
   FilterScreen({required this.filterApplyResult,required this.filterIndex});
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  List<String> countryList =
  [
    'Argentina',
    'Austria',
    'Australia',
    'Belgium',
    'Bulgaria',
    'Brazil',
    'Canada',
    'Switzerland',
    'China',
    'Colombia',
    'Czech Republic',
    'Germany',
    'Egypt',
    'Spain',
    'France',
    'UK',
    'Greece',
    'Hong Kong',
    'Hungary',
    'Indonesia',
    'Ireland',
    'Israel',
    'India',
    'Italy',
    'Japan',
    'South Korea',
    'Lithuania',
    'Latvia',
    'Mexico',
    'Malaysia',
    'Nigeria',
    'Netherlands',
    'New Zealand',
    'Philippines',
    'Poland',
    'Portugal',
    'Romania',
    'Serbia',
    'Russia',
    'Saudi Arabia',
    'Sweden',
    'Singapore',
    'Slovakia',
    'Thailand',
    'Turkey',
    'Taiwan',
    'Ukraine',
    'United States',
    'Venezuela',
    'South Africa'
  ];

  List<String> categoriesList=[
    "Top",
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];
  List<String> indianLanguages = [
    'Any',
    'Hindi',
    'Telugu',
    'Marathi',
    'Gujarati',
    'Kannada',
    'Odia',
    'Malayalam',
    'Punjabi',
  ];
  String filterOption = 'Country';

  List<String> filterList = [];

  List<int> selectedOptionFilters=[-1,-1,-1];


  @override
  void initState() {
    super.initState();
    selectedOptionFilters=widget.filterIndex;
    filterList.addAll(countryList);
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                MyBoldText(
                    text: 'Filters',
                    fontsize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyAppColor.primary_color),
                Expanded(child: Container()),
                InkWell(
                  onTap: (){
                    selectedOptionFilters=[-1,-1,-1];
                    setState(() {

                    });
                  },
                  child: MyBoldText(
                      text: 'Clear All',
                      fontsize: 12,
                      fontWeight: FontWeight.bold,
                      color: MyAppColor.black_light),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          selected = 0;
                          filterList = countryList;
                          filterOption = "Country";

                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: selected == 0
                                  ? MyAppColor.primary_light
                                  : Color(0xfff7f7f7),
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: MyAppColor.white_light))),
                          width: 150,
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                          child: Text(
                            'Country',
                            style: TextStyle(
                                fontSize: 15,
                                color: selected == 0
                                    ? MyAppColor.primary_color
                                    : MyAppColor.black_light,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selected = 1;
                          filterList = categoriesList;
                          filterOption = "Categories";
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: selected == 1
                                  ? MyAppColor.primary_light
                                  : Color(0xfff7f7f7),
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: MyAppColor.white_light))),
                          width: 150,
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 15,
                                color: selected == 1
                                    ? MyAppColor.primary_color
                                    : MyAppColor.black_light,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selected = 2;
                          filterList = indianLanguages;
                          filterOption = "Languages";
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: selected == 2
                                  ? MyAppColor.primary_light
                                  : Color(0xfff7f7f7),
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: MyAppColor.white_light))),
                          width: 150,
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                          child: Text(
                            'Languages',
                            style: TextStyle(
                                fontSize: 15,
                                color: selected == 2
                                    ? MyAppColor.primary_color
                                    : MyAppColor.black_light,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: MyAppColor.white_light,
                  ),
                  FilterOptionList(
                    filterList: filterList,
                    filterOption: filterOption,
                    selectedList: selectedOptionFilters,
                    selectedOptionFunction:(List<int> selected){

                      print(selected);
                      selectedOptionFilters=selected;
                    }


                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: MyElevatedButton(
              title: 'APPLY',
              height: 55,
              width: double.infinity,
              fontsize: 18,
              radius: 0,
              bg_color: MyAppColor.primary_color,
              fontWeight: FontWeight.bold,
              onPressed: () {
                List<String> result=[];
                if(selectedOptionFilters[0]!=-1){
                  result.add(countryList[selectedOptionFilters[0]]);
                }
                if(selectedOptionFilters[1]!=-1){
                  result.add(categoriesList[selectedOptionFilters[1]]);
                }
                if(selectedOptionFilters[2]!=-1){
                  result.add(indianLanguages[selectedOptionFilters[2]]);
                }
                widget.filterApplyResult(result,selectedOptionFilters);
                Navigator.pop(context);
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


}
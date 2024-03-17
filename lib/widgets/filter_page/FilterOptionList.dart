import 'package:flutter/material.dart';

import 'filter_checkbox_card.dart';

class FilterOptionList extends StatefulWidget {
  List<String> filterList;
  Function (List<int>) selectedOptionFunction;
  List<int> selectedList;
  String filterOption;

  FilterOptionList({required this.filterOption, required this.filterList,required this.selectedList,required this.selectedOptionFunction});

  @override
  State<FilterOptionList> createState() => _FilterOptionListState();
}

class _FilterOptionListState extends State<FilterOptionList> {
  int currentSelected=-1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSelected=getCurrentSelected();


  }

  @override
  Widget build(BuildContext context) {
    currentSelected=getCurrentSelected();

    return Expanded(
      child: ListView.builder(
          itemCount: widget.filterList.length,
          itemBuilder: (context,index) {
            return FilterCheckBoxCard(
                isSelected: index==currentSelected,
                id: index,
                callback: (id) {
                  setSelectedOption(id);
                  widget.selectedOptionFunction(widget.selectedList);
                  currentSelected=getCurrentSelected();
                  setState(() {
                  });
                },
                text: widget.filterList[index]);
          }),
    );
  }

  void setSelectedOption(int id) {
    if(widget.filterOption=='Country'){
      widget.selectedList[0]=id;
    }else if(widget.filterOption=='Categories'){
      widget.selectedList[1]=id;
    }else {
      widget.selectedList[2]=id;

    }

  }

  int getCurrentSelected() {
    if(widget.filterOption=='Country'){

      return widget.selectedList[0];
    }else if(widget.filterOption=='Categories'){

      return widget.selectedList[1];
    }

    return widget.selectedList[2];
  }
}
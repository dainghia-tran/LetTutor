import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;

class TagsListSelector extends StatefulWidget {
  const TagsListSelector(
      {Key? key,
      required this.tagsList,
      this.selectFirstItem = false,
      this.isHorizontal = false,
      this.readOnly = false,
      this.onSelectedList,
      this.defaultSelected})
      : super(key: key);
  final List<String> tagsList;
  final bool selectFirstItem;
  final bool isHorizontal;
  final bool readOnly;
  final Function(List<String>)? onSelectedList;
  final List<String>? defaultSelected;
  @override
  _TagsListSelectorState createState() => _TagsListSelectorState();
}

class _TagsListSelectorState extends State<TagsListSelector> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List<String> selectedList = [];
  var formatedList = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedList = widget.defaultSelected ?? [];
    });
    formatedList = tutor_utils.getFormatedTags(widget.tagsList);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          widget.isHorizontal == true ? Axis.horizontal : Axis.vertical,
      child: Tags(
        key: _tagStateKey,
        itemCount: formatedList.length,
        alignment: WrapAlignment.start,
        itemBuilder: (index) {
          final item = formatedList[index];
          return ItemTags(
            padding: const EdgeInsets.all(8),
            textStyle: const TextStyle(
              fontSize: 14,
            ),
            textActiveColor: const Color.fromRGBO(0, 113, 240, 1),
            activeColor: const Color.fromRGBO(221, 234, 255, 1),
            elevation: 0,
            key: Key(index.toString()),
            index: index,
            title: item,
            pressEnabled: widget.readOnly == true ? false : true,
            active: (index == 0 && widget.selectFirstItem == true) ||
                    widget.readOnly == true ||
                    selectedList.contains(item)
                ? true
                : false,
            color: const Color(0xffe4e6eb),
            textColor: const Color(0xff646464),
            onPressed: widget.readOnly
                ? null
                : (item) {
                    setState(() {
                      if (selectedList.contains(item.title)) {
                        selectedList.remove(item.title);
                      } else {
                        selectedList.add(item.title ?? '');
                      }
                    });
                    widget.onSelectedList!(selectedList);
                  },
          );
        },
      ),
    );
  }
}

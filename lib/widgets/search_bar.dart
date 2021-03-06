import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, this.onClick}) : super(key: key);
  final onClick;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: Color(0xFF303030),
                ),
              ),
              TextFormField(
                maxLines: 1,
                onFieldSubmitted: (String keyword) => widget.onClick(keyword),
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 32, right: 8),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Color(0xFF303030)),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

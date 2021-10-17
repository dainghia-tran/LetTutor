import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPageBloc extends ChangeNotifier{
  var currentPageIndex = 0;

  static MainPageBloc of(context, {listen = true}){
    return Provider.of<MainPageBloc>(context, listen: listen);
  }

  void changePage(newIndex){
    currentPageIndex = newIndex;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class StarRatingBar extends StatelessWidget {
  StarRatingBar({Key? key, required this.stars, this.max}) : super(key: key);
  final double stars;
  int? max;

  @override
  Widget build(BuildContext context) {
    int intStar = stars.floor();
    double mod = stars - intStar;
    List<Widget> starIcons = [];
    for(var i = 0; i < (max ?? 5); ++i){
      if(i < intStar){
        starIcons.add(const Icon(Icons.star_rounded, color: Colors.amberAccent, size: 20,));
      }else if(i == intStar && mod > 0){
        starIcons.add(const Icon(Icons.star_half_rounded, color: Colors.amberAccent, size: 20,));
      }else{
        starIcons.add(const Icon(Icons.star_border_rounded, color: Colors.amberAccent, size: 20,));
      }
    }
    return Row(
      children: starIcons,
    );
  }
}

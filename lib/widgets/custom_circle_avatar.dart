import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({Key? key, required this.avatarUrl, this.dimension})
      : super(key: key);
  final String avatarUrl;
  final double? dimension;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular((dimension ?? 50) / 2),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        height: dimension ?? 50,
        width: dimension ?? 50,
        imageUrl: avatarUrl,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileAvatar({Key key, this.imageUrl, this.radius = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
      ],
    );
  }
}

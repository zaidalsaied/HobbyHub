import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hobby_hub_ui/screens/res/svg_assets.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileAvatar({Key key, this.radius = 20, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: radius,
      child: Container(
          width: 100,
          height: 100,
          child: SvgPicture.string(SvgAssets.signUpAvatar),
          decoration:
              BoxDecoration(shape: BoxShape.circle, border: Border.all())),
      foregroundImage: CachedNetworkImageProvider(imageUrl ?? ''),
    );
  }
}

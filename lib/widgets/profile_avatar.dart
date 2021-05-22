import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/screens/user_profile.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileAvatar({Key key, this.radius = 20, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
        backgroundImage: CachedNetworkImageProvider(imageUrl ??
            UserController().currentUser.imgUrl ??
            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg'),
      ),
    );
  }
}

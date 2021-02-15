import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                "https://1.bp.blogspot.com/-7J1QxG7-dJU/U9pShrClwGI/AAAAAAAAEf8/oxwnD8ihkGs/s1600/example.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

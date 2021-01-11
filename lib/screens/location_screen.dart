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
                "https://uxw.hcgwhining.pw/img/582878.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

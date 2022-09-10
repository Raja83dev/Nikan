import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class BannerButton extends StatelessWidget {
   BannerButton({required this.imageUrl,required this.siteUrl});


  String imageUrl;
  String siteUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        width: 100.w,
        height: 40.w,
        decoration: BoxDecoration(

          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: CachedNetworkImageProvider(imageUrl)
          ,
          ), 
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch_clipper/flutter_switch_clipper.dart';
import 'package:sizer/sizer.dart';

import 'package:nikan_app/models/tag_model.dart';

class TagButton extends StatelessWidget {
  TagModel tagModel;

  TagButton({
    required this.tagModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.w),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    tagModel.image,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              tagModel.name,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.black45,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

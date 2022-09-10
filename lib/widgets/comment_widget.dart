import 'package:comment_tree/comment_tree.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';

import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:nikan_app/models/product_detail_model.dart' as model;

class CommentWidget extends StatelessWidget {
  CommentWidget({required this.commentModel});

  List<model.Comment> commentModel;
  @override
  Widget build(BuildContext context) {
    return CommentTreeWidget<Comment, Comment>(
      Comment(
          avatar: 'null',
          userName: 'null',
          content: 'felangel made felangel/cubit_and_beyond public '),
      List.generate(commentModel.length, (index) {
        return Comment(
            avatar: 'null',
            userName: commentModel[index].user,
            content: commentModel[index].textCm);
      }),
      treeThemeData: TreeThemeData(lineColor: Colors.green[500]!, lineWidth: 3),
      avatarRoot: (context, data) => PreferredSize(
        child: SizedBox(),
        preferredSize: Size.zero,
      ),
      avatarChild: (context, data) => PreferredSize(
        child: SizedBox(),
        preferredSize: Size.zero,
      ),
      contentChild: (context, data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.userName}',
                    style: PersianFonts.Yekan.copyWith(
                      height: 1.5,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${data.content}',
                    style: PersianFonts.Yekan.copyWith(
                      height: 1.5,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      contentRoot: (context, data) {
        return SizedBox();
      },
    );
  }
}

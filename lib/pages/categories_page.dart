import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:nikan_app/controllers/categories_controller.dart';
import 'package:sizer/sizer.dart';

class CategoriesPage extends GetView<CategoriesController> {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      width: 100.w,
      child: Obx(
        () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 6.h,
              ),
              Text(
                "all_tags".tr,
                style: PersianFonts.Vazir.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
              Flexible(
                child: ListView(
                  children: List.generate(controller.tagList.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h / 5),
                      child: Material(
                        elevation: 1,
                        child: ListTile(
                          onTap: () {},
                          trailing: Icon(Icons.chevron_right_outlined),
                          title: Text(
                            controller.tagList[index].name,
                            style: PersianFonts.Vazir.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
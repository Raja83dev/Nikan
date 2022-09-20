import 'package:get/get.dart';
import 'package:nikan_app/controllers/archive_controller.dart';
import 'package:nikan_app/controllers/categories_controller.dart';
import 'package:nikan_app/controllers/edit_profile_controller.dart';
import 'package:nikan_app/controllers/home_controller.dart';
import 'package:nikan_app/controllers/login_controller.dart';
import 'package:nikan_app/controllers/main_controller.dart';
import 'package:nikan_app/controllers/product_detail_controller.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/controllers/saved_list_controller.dart';
import 'package:nikan_app/controllers/search_controller.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:nikan_app/controllers/sub_category_controller.dart';
import 'package:nikan_app/pages/product_detail_page.dart';
import 'package:nikan_app/pages/search_page.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCategoryController>(() => SubCategoryController(),
        fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<CategoriesController>(() => CategoriesController(),
        fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(),
        fenix: true);
    Get.lazyPut<ShopCartController>(() => ShopCartController(), fenix: true);
    Get.lazyPut<ShopCartController>(() => ShopCartController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<SavedListController>(() => SavedListController(), fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(),
        fenix: true);

    Get.lazyPut<ArchiveController>(() => ArchiveController(), fenix: true);
  }
}

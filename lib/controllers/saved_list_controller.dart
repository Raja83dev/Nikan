import 'package:get/get.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/models/save_product_model.dart';
import 'package:nikan_app/services/api_service.dart';

class SavedListController extends GetxController {
  List<SaveProductModel>? saves;

  var isloading = false.obs;
  Future<void> getSaves() async {
    isloading.value = true;
    var data = (await ApiService.productSaveList());
    saves = data;
    isloading.value = false;
  }
}

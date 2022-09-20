import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/models/user_model.dart';
import 'package:nikan_app/services/api_service.dart';

class EditProfileController extends GetxController {
  TextEditingController nameField = TextEditingController();
  TextEditingController phoneField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController jobField = TextEditingController();
  TextEditingController idNumberField = TextEditingController();
  TextEditingController bornField = TextEditingController();

  UserModel? userData;

  var isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    print("GETTTT DATAA");
    isloading.value = true;

    userData = await ApiService.getUserDatas();
    nameField.text = userData!.fullName!;
    phoneField.text = userData!.phone!;
    emailField.text = userData!.email!;
    jobField.text = userData!.job!;
    idNumberField.text = userData!.idNumber!;
    bornField.text = userData!.born!;

    isloading.value = false;
  }

  void saveUserData() async {
    isloading.value = true;
    update(['main']);
    var imageData = uploadimage!;

    if (uploadimage == userData!.avatar!) {
      print("Web Applyed");
      imageData = "";
    }
    if (uploadimage == "100") {
      print("Mot Avaible");
      imageData = "";
    }

    await ApiService.saveUserData(UserModel(
      fullName: nameField.text,
      avatar: imageData,
      phone: phoneField.text,
      born: bornField.text,
      email: emailField.text,
      idNumber: idNumberField.text,
      job: jobField.text,
    ));
    await getData();
    await Get.find<ProfileController>().getData();
    Get.back();
    isloading.value = false;
   
  }

  String? uploadimage = "";

  void selectImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'cut'.tr,
              toolbarColor: accentColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'cut'.tr,
          ),
        ],
      );
      if (croppedFile != null) {
        uploadimage = croppedFile.path;
      }
    }
    isloading.value=true;
    isloading.value=false;
  }
}

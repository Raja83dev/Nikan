import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/models/city_model.dart';
import 'package:nikan_app/models/state_model.dart';
import 'package:nikan_app/models/user_model.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

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
    await getAreas();
    nameField.text = userData!.fullName!;
    phoneField.text = userData!.phone!;
    emailField.text = userData!.email!;
    jobField.text = userData!.job!;
    idNumberField.text = userData!.idNumber!;
    bornField.text = userData!.born!;

    uploadimage = userData!.avatar;

    // if (userData!.state == "") {
    //   selectedState.value = 100000;
    // } else {
    //   selectedState.value = states.indexOf(
    //       states.where((element) => element.title == userData!.state).first);
    // }

    // if (userData!.city == "") {
    //   selectedCity.value = 100000;
    // } else {
    //   selectedCity.value = cities.indexOf(
    //       cities.where((element) => element.title == userData!.city).first);
    // }

    isloading.value = false;
  }

  List<StateModel> states = <StateModel>[];
  List<CityModel> cities = <CityModel>[];

  var selectedCity = 100000.obs;
  var selectedState = 100000.obs;

  Future<void> getAreas() async {
    states = await ApiService.getStates();
    cities = await ApiService.getCities();
  }

  void openCitySelectDialog() {
    var buildList = cities
        .where((element) => element.state_id == states[selectedState.value].id)
        .toList();
    Get.bottomSheet(Container(
      width: 100.w,
      height: 50.h,
      padding: EdgeInsets.only(top: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.w)), //border corner radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), //color of shadow
            spreadRadius: 1, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 1),
          ),
          //you can set more BoxShadow() here
        ],
      ),
      child: LiveList(
        separatorBuilder: (context, index) {
          return Divider();
        },
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: ListTile(
              onTap: () {
                selectedCity.value = buildList[index].id;

                Get.back();
              },
              title: Text(
                buildList[index].title,
                style: PersianFonts.Vazir.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
        itemCount: buildList.length,
      ),
    ));
  }

  void openStateSelectDialog() {
    Get.bottomSheet(Container(
      width: 100.w,
      height: 50.h,
      padding: EdgeInsets.only(top: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.w)), //border corner radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), //color of shadow
            spreadRadius: 1, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 1),
          ),
          //you can set more BoxShadow() here
        ],
      ),
      child: LiveList(
        separatorBuilder: (context, index) {
          return Divider();
        },
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: ListTile(
              onTap: () {
                selectedState.value = states[index].id;

                Get.back();
              },
              title: Text(
                states[index].title,
                style: PersianFonts.Vazir.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
        itemCount: states.length,
      ),
    ));
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
      city: selectedCity.value.toString(),
      born: bornField.text,
      email: emailField.text,
      idNumber: idNumberField.text,
      job: jobField.text,
      state: selectedState.value.toString(),
    ));
    await getData();
    await Get.find<ProfileController>().getData();
    isloading.value = false;
    Get.back();
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
    isloading.value = true;
    isloading.value = false;
  }
}

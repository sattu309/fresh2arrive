import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../repositories/user_profile_repository.dart';
import '../resources/api_url.dart';

class ProfileController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<ProfileModel> model = ProfileModel().obs;
  Rx<File> image = File("").obs;
  final ImagePicker picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String userId = "";
  getCurrentUserId() async {
    userId = await getUserId();
  }
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    userProfileData().then((value) {
      isDataLoading.value = true;
      model.value = value;
      if (isDataLoading.value &&
          model.value.data != null) {
        nameController.text =
            model.value.data!.user!.name.toString();
        emailController.text =
            model.value.data!.user!.email.toString();
        mobileController.text =
            model.value.data!.user!.phone.toString();
      }
    });
  }


  updateUserDetailsOnFirebaseDatabase() async {
    String myUserId = (await getUserId()).toString();
    Map<String, dynamic> updates = {};
    Map<String, dynamic> newMessageMap = {};
    newMessageMap["user_details"] = model.value.data!.toJson();
    updates["users/$myUserId"] = newMessageMap;
    firebaseDatabase.ref().update(updates).then((value) {
      log("Firebase message updated...........");
    });
  }

}

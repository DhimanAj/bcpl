import 'package:bcpl_fun_club_project/infrastructure/model/all_winner_name.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../infrastructure/constants/app_constants.dart';
import '../../infrastructure/core/widget/progress_dialog.dart';
import '../../infrastructure/model/all_gift_model.dart';
import '../../infrastructure/model/gift_status_model.dart';
import '../../infrastructure/model/winners_model.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/network/dio_client.dart';
import '../../infrastructure/preference/preference_manager.dart';
import '../../infrastructure/shared/Utils/snackbar.util.dart';
import '../../infrastructure/shared/app_exception_handle.dart';
import '../../infrastructure/shared/custom_http_exception.dart';

class ManageSubscriptionController extends GetxController {
  PageController pageController = PageController();
  ProgressDialog progressDialog = ProgressDialog();
  late LocationPermission permission;
  var serviceEnabled = false.obs;
  var text = "access_your_location".obs;

  var giftData = <MessageData>[].obs;
  var giftWinner = <MessageWinnerName>[].obs;
  // final dio = Dio();
  var isLoading = false.obs;
  var giftImage = "".obs;
  var giftMessage = "".obs;

  var mobileController = TextEditingController();
  // var getDataModel = WinnerModel().obs;
  // var getDataModel1 = GiftModel().obs;

  @override
  void onInit() {
    Future.delayed(Duration.zero,()async{
      getDataFromApi();
      getAllWinner();
    });
    // getDataFromApi1();
    super.onInit();
  }

  checkLocation() async {
    print("checkLocation");
    serviceEnabled.value = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always ||
        permission == LocationPermission.unableToDetermine) {
      Get.toNamed(Routes.detailsPage);
      PreferenceManager.setBool(AppConstants.locationEnable, true);
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        PreferenceManager.setBool(AppConstants.locationEnable, false);
        // PreferenceManager.setBool(AppConstants.isLogin, false);

        return Future.error('Location permissions are denied');
      } else {
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always ||
            permission == LocationPermission.unableToDetermine) {
          Get.toNamed(Routes.detailsPage);
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      PreferenceManager.setBool(AppConstants.locationEnable, false);
      // PreferenceManager.setBool(AppConstants.isLogin, false);

      // return locationAlert(Get.context);
      return openAppSettings();
      // Future.error(
      //   'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

 getDataFromApi() async {
    giftData.clear();
    try {
      progressDialog.show();
      AllGift allGift = await DioClient.base().getAllGift();
      if (allGift.status!) {
        progressDialog.dismiss();
        giftData.addAll(allGift.message!);
        giftData.refresh();
        print("allgiftfetchsuccess ");
      } else {
        progressDialog.dismiss();
        print("allgiftfail");
        SnackBarUtil.showError(message: allGift.message.toString());
      }
    } on CustomHttpException catch (exception, code) {
      progressDialog.dismiss();

      AppExceptionHandle().showException(
          exception.code, exception.response, exception.exception,
          type: exception.code);
    } catch (e) {
      progressDialog.dismiss();

      print("api_exception_allGift");
      print(e);
    }
  }

 getAllWinner() async {
   giftWinner.clear();
    try {
      progressDialog.show();
      AllWinerName winerName = await DioClient.base().getAllWinner();
      if (winerName.status!) {
        progressDialog.dismiss();
        giftWinner.addAll(winerName.message!);
        giftWinner.refresh();
        print("allgiftfetchsuccess ");
      } else {
        progressDialog.dismiss();
        print("allgiftfail");
        SnackBarUtil.showError(message: winerName.message.toString());
      }
    } on CustomHttpException catch (exception, code) {
      progressDialog.dismiss();

      AppExceptionHandle().showException(
          exception.code, exception.response, exception.exception,
          type: exception.code);
    } catch (e) {
      progressDialog.dismiss();

      print("api_exception_allGift");
      print(e);
    }
  }

 checkYourGift() async {
    try {
      progressDialog.show();
      Map<String, dynamic> mapData = {};
      mapData['contactNo'] = mobileController.text;

      GiftStatusModel giftstatus = await DioClient.base().giftStatus(mapData);
      if (giftstatus.status!) {
        progressDialog.dismiss();
        giftImage.value = giftstatus.image! ?? "";
        giftMessage.value = giftstatus.message! ?? "";
        print("allgiftfetchsuccess ");
      } else {
        progressDialog.dismiss();
        print("allgiftfail");
        SnackBarUtil.showError(message: giftstatus.message.toString());
      }
    } on CustomHttpException catch (exception, code) {
      progressDialog.dismiss();

      AppExceptionHandle().showException(
          exception.code, exception.response, exception.exception,
          type: exception.code);
    } catch (e) {
      progressDialog.dismiss();

      print("api_exception_allGift");
      print(e);
    }
  }

}

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../infrastructure/core/widget/progress_dialog.dart';
import '../../infrastructure/model/otp_model.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/network/dio_client.dart';
import '../../infrastructure/shared/Utils/snackbar.util.dart';
import '../../infrastructure/shared/app_exception_handle.dart';
import '../../infrastructure/shared/custom_http_exception.dart';

class DetailsController extends GetxController {
  var scannedNumber = ''.obs;
  late bool mounted;
  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final imeiController = TextEditingController();
  final otpController = TextEditingController();
  final addressController = TextEditingController();
  final pinController = TextEditingController();
  final modelController = TextEditingController();
  final oldbrandController = TextEditingController();
  var lat = 0.0.obs;
  var long = 0.0.obs;
  var imagePath = "".obs;
  var compressImagePath = "".obs;

  ProgressDialog progressDialog = ProgressDialog();
  var userPhoto1 = ''.obs;
  var userPhoto2 = ''.obs;
  var fileName1 = ''.obs;
  var fileName2 = ''.obs;
  var sendOtpmessage = false.obs;
  var modelname = ''.obs;
  var manufacturer = ''.obs;
  var brand = ''.obs;

  late LocationPermission permission;
  var serviceEnabled = false.obs;
  var text = "access_your_location".obs;
  var locationDescription = "".obs;
  var imeiVerified = false.obs;
  @override
  void onInit() {
    // scanBarCode();
    getLatLong();
    getDeviceDetails();
    super.onInit();
  }



  //  scanBarCode() async {
  //   String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
  //       '#000000', Res.cancel, true, ScanMode.BARCODE);
  //   if (!mounted) return;
  //   scannedNumber.value = barcodeScanResult;
  // }

  sendOtp() async {
    try {
      progressDialog.show();
      Map<String, dynamic> mapData = {};
      mapData['name'] = nameController.text;
      mapData['number'] = numberController.text.trim();
      mapData['imeiNo'] = imeiController.text.trim();
      print("allgiftfetchsuccess $mapData ${nameController.text}");

      SendOtpModel sendOtp = await DioClient.base().sendOtp(mapData);
      if (sendOtp.status!) {
        progressDialog.dismiss();
        SnackBarUtil.showSuccess(message: sendOtp.message.toString());
        sendOtpmessage.value = true;

        print("allgiftfetchsuccess");
      } else {
        progressDialog.dismiss();
        print("allgiftfail");
        SnackBarUtil.showError(message: sendOtp.message.toString());
      }
    } on CustomHttpException catch (exception, code) {
      progressDialog.dismiss();
      AppExceptionHandle().showException(exception.code, exception.response, exception.exception, type: exception.code);
    } catch (e) {
      progressDialog.dismiss();
      print("api_exception_allGift");
      print(e);
    }
  }

  verifyOtp() async {
    try {
      progressDialog.show();
      Map<String, dynamic> mapData = {};
      mapData['name'] = nameController.text;
      mapData['number'] = numberController.text.trim();
      mapData['otp'] = otpController.text.trim();
      print("allgiftfetchsuccess $mapData ${nameController.text}");

      SendOtpModel sendOtp = await DioClient.base().verifyOtp(mapData);
      if (sendOtp.status!) {
        progressDialog.dismiss();

        print("allgiftfetchsuccess ");
      } else {
        progressDialog.dismiss();
        print("allgiftfail");
        SnackBarUtil.showError(message: sendOtp.message.toString());
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

  verifyImei(res) async {
    try {
      imeiController.text = res;
      progressDialog.show();
      Map<String, dynamic> mapData = {};
      mapData['imeiNo'] = imeiController.text;

      SendOtpModel sendOtp = await DioClient.base().verifyImei(mapData);
      if (sendOtp.status!) {
        imeiVerified.value = true;
        progressDialog.dismiss();
        SnackBarUtil.showSuccess(message: sendOtp.message.toString());

        print("allgiftfetchsuccess ");
      } else {
        progressDialog.dismiss();
        print("allgiftfail");
        SnackBarUtil.showError(message: sendOtp.message.toString());
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

  getDeviceDetails() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      final deviceAndroidInfo = await deviceInfoPlugin.androidInfo;
      modelname.value = deviceAndroidInfo.model;
      manufacturer.value = deviceAndroidInfo.manufacturer;
      manufacturer.value = deviceAndroidInfo.manufacturer;
      brand.value = deviceAndroidInfo.brand;

      // print("deviceInfo ${deviceAndroidInfo.model}");
      // print("deviceInfo ${deviceAndroidInfo.board}");
      // print("deviceInfo ${deviceAndroidInfo.version}");
      // print("deviceInfo ${deviceAndroidInfo.device}");
      // print("deviceInfo ${deviceAndroidInfo.hardware}");
      // print("deviceInfo ${deviceAndroidInfo.serialNumber}");
      // print("deviceInfo ${deviceAndroidInfo.model}");
      // print("deviceInfo ${deviceAndroidInfo.manufacturer}");
      // return '${deviceAndroidInfo.brand} ${deviceAndroidInfo.device}';
    }
  }

  saveDataToDb() async {
    try {




      progressDialog.show();
      Map<String, dynamic> mapData = {};
      mapData['name'] = nameController.text;
      mapData['number'] = numberController.text.trim();
      mapData['imeiNo'] = imeiController.text.trim();
      mapData['address'] = addressController.text.trim();
      mapData['pin'] = pinController.text.trim();
      mapData['modelPurchase'] = modelController.text.trim();
      mapData['oldPhoneBrand'] = oldbrandController.text.trim();
      mapData['locationPoints'] = "Latitude: ${lat.value}, Longitude: ${long.value}";
      mapData['locationAddress'] = locationDescription.value;
      mapData['customerImageName'] = nameController.text.trim();
      mapData['customerInvoiceImageName'] = nameController.text.trim();
      mapData['brandNamebrandName'] = brand.value;
      mapData['modelName'] = modelname.value;
      mapData['manufacturerName'] =  manufacturer.value;
      mapData['customerImage'] = imagePath.value;
      mapData['customerInvoiceImage'] = userPhoto2.value;

      mapData['activationTime'] = imeiController.text.trim();
      print(mapData);
      SendOtpModel sendOtp = await DioClient.base().saveData(mapData);
      if (sendOtp.status!) {
        progressDialog.dismiss();
        Get.toNamed(Routes.scratchCard, arguments: [
          nameController.text,
          imeiController.text,
          numberController.text,
        ]);
        // SnackBarUtil.showSuccess(message: sendOtp.message.toString());

        print("allgiftfetchsuccess ");
      } else {
        progressDialog.dismiss();
        print("allgiftfail");
        SnackBarUtil.showError(message: sendOtp.message.toString());
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

  getLatLong() async {
    Position position = await Geolocator.getCurrentPosition();
    lat.value = position.latitude;
    long.value = position.longitude;
    print("lat.");
    print(lat.value);
    print(long.value);
    List<Placemark> placemarks = await placemarkFromCoordinates(lat.value, long.value);
    locationDescription.value =
    "${placemarks[0].name} ${placemarks[0].subLocality!}, ${placemarks[0].locality!} ${placemarks[0].name}";
    print("ADDRESSS ${placemarks[0].subLocality!}, ${placemarks[0].locality!}, ");
  }

  getImage(ImageSource imageSource, context, imgType) async {
    var date = DateTime.now();
    String imgPath = date.millisecondsSinceEpoch.toString();
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: imageSource);
    print('picked image');
    if (image!.path.isNotEmpty) {
      // Compress
      final dir = Directory.systemTemp;
      final targetPath = "${dir.absolute.path}/$imgPath.jpg";

      print("userPhoto__1 ${targetPath}");
      File userFile2 = File(image.path);
      List<int>imageByte2 = userFile2.readAsBytesSync();
      imagePath.value = base64Encode(imageByte2);
    }
  }

  getinvoiceImage(ImageSource imageSource, context, imgType) async {
    var date = DateTime.now();
    String imgPath = date.millisecondsSinceEpoch.toString();
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: imageSource);
    print('picked image');
    if (image!.path.isNotEmpty) {

      // Compress
      final dir = Directory.systemTemp;
      final targetPath = "${dir.absolute.path}/$imgPath.jpg";
      File userFile2 = File(image.path);
      List<int>imageByte2 = userFile2.readAsBytesSync();
      userPhoto2.value = base64Encode(imageByte2);
      print("userPhoto__1 ${targetPath}");
  }}

   scanner( context) async {
     var res = await Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => const SimpleBarcodeScannerPage(),
         ));
     print("scanningvalue $res");
     verifyImei(res);
   }

   onChangeimei(String text) {
    if(text.length == 15){
      verifyImei(text);
    }
   }
}

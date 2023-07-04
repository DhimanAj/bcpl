import 'package:confetti/confetti.dart';
import 'package:get/get.dart';

import '../../infrastructure/core/widget/progress_dialog.dart';
import '../../infrastructure/model/gift_detail_model.dart';
import '../../infrastructure/network/dio_client.dart';
import '../../infrastructure/shared/app_exception_handle.dart';
import '../../infrastructure/shared/custom_http_exception.dart';

class ScratchCardController extends GetxController {
  ConfettiController mainScratch = ConfettiController();
  ProgressDialog progressDialog = ProgressDialog();
  var giftDetail = "".obs;
  var giftImage = "".obs;

  var name = "".obs;
  var number = "".obs;
  var imei = "".obs;

  @override
  void onInit() {
    // _controller = ConfettiController(
    //   duration: const Duration(seconds: 2),
    // );
    mainScratch = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    Future.delayed(Duration.zero, () async {
      await giftDetailApi();

    });
    name.value = Get.arguments[0];
    imei.value = Get.arguments[1];
    number.value = Get.arguments[2];

    super.onInit();
  }

  giftDetailApi() async {
    try {
      // progressDialog.show();
      Map<String, dynamic> mapData = {};
      mapData['name'] = name.value;
      mapData['number'] = number.value;
      mapData['imeiNo'] = imei.value;


      GiftDetailsModel sendOtp = await DioClient.base().giftDetail(mapData);
      progressDialog.dismiss();
      giftImage.value = sendOtp.giftImage ?? "";
      giftDetail.value = sendOtp.giftDetail ?? "";
    } on CustomHttpException catch (exception, code) {
      progressDialog.dismiss();
      print("CustomHttpException ${exception}");
      AppExceptionHandle().showException(exception.code, exception.response, exception.exception, type: exception.code);
    } catch (e) {
      progressDialog.dismiss();

      print("api_exception_allGift $e");
      print(e);
    }
  }

  sendGiftMessage() async {
    try {
      // progressDialog.show();
      Map<String, dynamic> mapData = {};
      mapData['name'] = name.value;
      mapData['number'] = number.value;
      mapData['imeiNo'] = imei.value;

      GiftDetailsModel sendOtp = await DioClient.base().giftMessage(mapData);
    } on CustomHttpException catch (exception, code) {
      progressDialog.dismiss();

      AppExceptionHandle().showException(exception.code, exception.response, exception.exception, type: exception.code);
    } catch (e) {
      progressDialog.dismiss();

      print("api_exception_allGift");
      print(e);
    }
  }
}

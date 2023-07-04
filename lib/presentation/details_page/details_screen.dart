import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/shared/common_functions.dart';
import '../../infrastructure/theme/colors.theme.dart';
import '../../infrastructure/theme/text.theme.dart';
import 'details_controller.dart';

class DetailsScreen extends GetView<DetailsController> {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorsTheme.colPrimary, ColorsTheme.col8B0000])),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                    padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: ColorsTheme.colWhite.withOpacity(0.75),
                      border: Border.all(
                          color: ColorsTheme.colBlack.withOpacity(0.35),
                          width: 1),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.nameController,
                      //keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: semiBoldTextStyle(
                          fontSize: dimen16, color: ColorsTheme.colBlack),
                      cursorColor: ColorsTheme.colPrimary,
                      onChanged: (text) {
                        //controller.onChangeEmail(text);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.account_box,
                            color: ColorsTheme.colPrimary,
                          ),
                          hintText: 'Full Name'.tr,
                          hintStyle: regularTextStyle(
                              fontSize: dimen12, color: ColorsTheme.colBlack),
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 10, right: 5),
                          padding: const EdgeInsets.only(
                              left: 10, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            color: ColorsTheme.colWhite.withOpacity(0.75),
                            border: Border.all(
                                color: ColorsTheme.colBlack.withOpacity(0.35),
                                width: 1),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: TextFormField(
                            controller: controller.imeiController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            style: semiBoldTextStyle(
                                fontSize: dimen14, color: ColorsTheme.colBlack),
                            cursorColor: ColorsTheme.colBlack,
                            onChanged: (text) {
                              //controller.onChangeEmail(text);
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.phone_android,
                                  color: ColorsTheme.colPrimary,
                                ),
                                hintText: "Imei",
                                hintStyle: regularTextStyle(
                                    fontSize: dimen12,
                                    color: ColorsTheme.colBlack),
                                contentPadding: const EdgeInsets.only(
                                  top: 0,
                                  bottom: 0,
                                )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.verifyImei();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                            top: 10,
                            right: 10,
                          ),
                          padding: const EdgeInsets.only(
                              left: 5, top: 4, bottom: 4, right: 5),
                          decoration: BoxDecoration(
                            color: ColorsTheme.colWhite.withOpacity(0.75),
                            border: Border.all(
                                color: ColorsTheme.colBlack.withOpacity(0.35),
                                width: 1),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: IconButton(
                            color: ColorsTheme.colBlack,
                            onPressed: () {
                              controller.verifyImei();
                            },
                            icon: const Icon(Icons.qr_code_scanner),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() => controller.imeiVerified.value
                      ? Container(
                    margin: const EdgeInsets.only(top: 10,right: 10),
                    width: Get.width,
                        alignment: Alignment.centerRight,
                        child: Text(
                            "Verified",
                            style: regularTextStyle(
                                fontSize: dimen14, color: ColorsTheme.colWhite),
                          ),
                      )
                      : Container()),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         margin: const EdgeInsets.only(
                  //             left: 10, top: 10, right: 5),
                  //         padding: const EdgeInsets.only(
                  //             left: 10, top: 4, bottom: 4),
                  //         decoration: BoxDecoration(
                  //           color: ColorsTheme.colWhite.withOpacity(0.75),
                  //           border: Border.all(
                  //               color: ColorsTheme.colBlack.withOpacity(0.35),
                  //               width: 1),
                  //           borderRadius: BorderRadius.circular(
                  //             10,
                  //           ),
                  //         ),
                  //         child: Obx(
                  //             () => Text(' ${controller.scannedNumber.value}')),
                  //       ),
                  //     ),
                  //     ElevatedButton(
                  //
                  //       child: Image.asset(''),
                  //     ),
                  //   ],
                  // ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 10, right: 10),
                          padding: const EdgeInsets.only(
                              left: 10, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            color: ColorsTheme.colWhite.withOpacity(0.75),
                            border: Border.all(
                                color: ColorsTheme.colBlack.withOpacity(0.35),
                                width: 1),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: TextFormField(
                            controller: controller.numberController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            style: semiBoldTextStyle(
                                fontSize: dimen14, color: ColorsTheme.colBlack),
                            cursorColor: ColorsTheme.colBlack,
                            onChanged: (text) {
                              //controller.onChangeEmail(text);
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.call,
                                  color: ColorsTheme.colPrimary,
                                ),
                                hintText: 'Contact Number'.tr,
                                hintStyle: regularTextStyle(
                                    fontSize: dimen12,
                                    color: ColorsTheme.colBlack),
                                contentPadding: const EdgeInsets.only(
                                  top: 0,
                                  bottom: 0,
                                )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //Get.toNamed(Routes.finalPage);
                          controller.sendOtp();
                          //Get.offAndToNamed(Routes.dropdownScreen);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorsTheme.col8B0000,
                              ColorsTheme.colPrimary
                            ]),

                            /*tileMode: TileMode.decal,*/

                            border: Border.all(color: Colors.white54, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.only(
                              right: 10, top: 15, bottom: 10),
                          padding: const EdgeInsets.only(
                              left: 8, right: 10, top: 11, bottom: 11),
                          child: Center(
                            child: Text(
                              "Send Otp".tr,
                              style: regularTextStyle(
                                  fontSize: dimen14,
                                  color: ColorsTheme.colWhite),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Obx(() => controller.sendOtpmessage.value
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10),
                                padding: const EdgeInsets.only(
                                    left: 10, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color: ColorsTheme.colWhite.withOpacity(0.75),
                                  border: Border.all(
                                      color: ColorsTheme.colBlack
                                          .withOpacity(0.35),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: controller.otpController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  style: semiBoldTextStyle(
                                      fontSize: dimen14,
                                      color: ColorsTheme.colBlack),
                                  cursorColor: ColorsTheme.colBlack,
                                  onChanged: (text) {
                                    //controller.onChangeEmail(text);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.password,
                                        color: ColorsTheme.colPrimary,
                                      ),
                                      hintText: 'otp'.tr,
                                      hintStyle: regularTextStyle(
                                          fontSize: dimen12,
                                          color: ColorsTheme.colBlack),
                                      contentPadding: const EdgeInsets.only(
                                        top: 0,
                                        bottom: 0,
                                      )),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                //Get.toNamed(Routes.finalPage);
                                controller.verifyOtp();
                                //Get.offAndToNamed(Routes.dropdownScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    ColorsTheme.col8B0000,
                                    ColorsTheme.colPrimary
                                  ]),

                                  /*tileMode: TileMode.decal,*/

                                  border: Border.all(
                                      color: Colors.white54, width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: const EdgeInsets.only(
                                    right: 10, top: 15, bottom: 10),
                                padding: const EdgeInsets.only(
                                    left: 8, right: 10, top: 11, bottom: 11),
                                child: Center(
                                  child: Text(
                                    "Verify Otp".tr,
                                    style: regularTextStyle(
                                        fontSize: dimen14,
                                        color: ColorsTheme.colWhite),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container()),

                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                    padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: ColorsTheme.colWhite.withOpacity(0.75),
                      border: Border.all(
                          color: ColorsTheme.colBlack.withOpacity(0.35),
                          width: 1),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.addressController,
                      //keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: semiBoldTextStyle(
                          fontSize: dimen12, color: ColorsTheme.colBlack),
                      cursorColor: ColorsTheme.colBlack,
                      onChanged: (text) {
                        //controller.onChangeEmail(text);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.home,
                            color: ColorsTheme.colPrimary,
                          ),
                          hintText: 'Address'.tr,
                          hintStyle: regularTextStyle(
                              fontSize: dimen12, color: ColorsTheme.colBlack),
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                    padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: ColorsTheme.colWhite.withOpacity(0.75),
                      border: Border.all(
                          color: ColorsTheme.colBlack.withOpacity(0.35),
                          width: 1),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.pinController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      style: semiBoldTextStyle(
                          fontSize: dimen14, color: ColorsTheme.colBlack),
                      cursorColor: ColorsTheme.colBlack,
                      onChanged: (text) {
                        //controller.onChangeEmail(text);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.pin_drop_outlined,
                            color: ColorsTheme.colPrimary,
                          ),
                          hintText: 'Pin Code'.tr,
                          hintStyle: regularTextStyle(
                              fontSize: dimen12, color: ColorsTheme.colBlack),
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                    padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: ColorsTheme.colWhite.withOpacity(0.75),
                      border: Border.all(
                          color: ColorsTheme.colBlack.withOpacity(0.35),
                          width: 1),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.modelController,
                      //keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: semiBoldTextStyle(
                          fontSize: dimen14, color: ColorsTheme.colBlack),
                      cursorColor: ColorsTheme.colBlack,
                      onChanged: (text) {
                        //controller.onChangeEmail(text);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.phone_android,
                            color: ColorsTheme.colPrimary,
                          ),
                          hintText: 'Model Purchase'.tr,
                          hintStyle: regularTextStyle(
                              fontSize: dimen12, color: ColorsTheme.colBlack),
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                    padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: ColorsTheme.colWhite.withOpacity(0.75),
                      border: Border.all(
                          color: ColorsTheme.colBlack.withOpacity(0.35),
                          width: 1),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.oldbrandController,
                      //keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: semiBoldTextStyle(
                          fontSize: dimen14, color: ColorsTheme.colBlack),
                      cursorColor: ColorsTheme.colBlack,
                      onChanged: (text) {
                        //controller.onChangeEmail(text);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.phone_android_sharp,
                            color: ColorsTheme.colPrimary,
                          ),
                          hintText: 'Old Phone Brand'.tr,
                          hintStyle: regularTextStyle(
                              fontSize: dimen12, color: ColorsTheme.colBlack),
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            padding: const EdgeInsets.only(
                                left: 10, top: 4, bottom: 10),
                            decoration: BoxDecoration(
                              color: ColorsTheme.colWhite.withOpacity(0.75),
                              border: Border.all(
                                  color: ColorsTheme.colBlack.withOpacity(0.35),
                                  width: 1),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Obx(() => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    controller.userPhoto.isEmpty
                                        ? 'Custome Image'.tr
                                        : controller.fileName1.value,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: mediumTextStyle(
                                        fontSize: dimen12,
                                        color: ColorsTheme.colBlack),
                                  ),
                                ))

/*                          TextFormField(
                            //controller: controller.emailController,
                            //keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            style: semiBoldTextStyle(
                                fontSize: dimen12, color: ColorsTheme.colBlack),
                            cursorColor: ColorsTheme.colBlack,
                            onChanged: (text) {
                              //controller.onChangeEmail(text);
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: ColorsTheme.colPrimary,
                                ),
                                hintText: 'customer_image'.tr,
                                hintStyle: regularTextStyle(
                                    fontSize: dimen12,
                                    color: ColorsTheme.colBlack),
                                contentPadding: const EdgeInsets.only(
                                  top: 0,
                                  bottom: 0,
                                )),
                          ),*/
                            ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.getImage(
                              ImageSource.camera, context, 'customImage');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorsTheme.col8B0000,
                              ColorsTheme.colPrimary
                            ]),

                            /*tileMode: TileMode.decal,*/

                            border: Border.all(color: Colors.white54, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.only(
                              right: 10, top: 15, bottom: 10),
                          padding: const EdgeInsets.only(
                              left: 8, right: 10, top: 11, bottom: 11),
                          child: Center(
                            child: Text(
                              "add".tr,
                              style: regularTextStyle(
                                  fontSize: dimen14,
                                  color: ColorsTheme.colWhite),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            padding: const EdgeInsets.only(
                                left: 10, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                              color: ColorsTheme.colWhite.withOpacity(0.75),
                              border: Border.all(
                                  color: ColorsTheme.colBlack.withOpacity(0.35),
                                  width: 1),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Obx(() => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    controller.userPhoto2.isEmpty
                                        ? 'Invoice Image'.tr
                                        : controller.fileName2.value,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: mediumTextStyle(
                                        fontSize: dimen12,
                                        color: ColorsTheme.colBlack),
                                  ),
                                ))),
                      ),
                      InkWell(
                        onTap: () {
                          controller.getImage(
                              ImageSource.camera, context, 'invoiceImage');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorsTheme.col8B0000,
                              ColorsTheme.colPrimary
                            ]),
                            /*tileMode: TileMode.decal,*/
                            border: Border.all(color: Colors.white54, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.only(
                              right: 10, top: 15, bottom: 10),
                          padding: const EdgeInsets.only(
                              left: 8, right: 10, top: 11, bottom: 11),
                          child: Center(
                            child: Text(
                              "add".tr,
                              style: regularTextStyle(
                                  fontSize: dimen14,
                                  color: ColorsTheme.colWhite),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      CommonFunction.keyboardDismiss(context);

                      controller.saveDataToDb();

                      // Get.toNamed(Routes.scratchCard, arguments: [
                      //   controller.nameController.text,
                      //   controller.imeiController.text,
                      //   controller.numberController.text,
                      // ]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          ColorsTheme.col8B0000,
                          ColorsTheme.colPrimary
                        ]),

                        /*tileMode: TileMode.decal,*/

                        border: Border.all(color: Colors.white54, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, top: 20, bottom: 20),
                      padding: const EdgeInsets.only(top: 11, bottom: 11),
                      child: Center(
                        child: Text(
                          "submit".tr,
                          style: regularTextStyle(
                              fontSize: dimen14, color: ColorsTheme.colWhite),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

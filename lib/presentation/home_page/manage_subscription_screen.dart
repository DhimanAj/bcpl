import 'package:bcpl_fun_club_project/infrastructure/shared/common_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../infrastructure/core/base/base_view.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/colors.theme.dart';
import '../../infrastructure/theme/text.theme.dart';
import '../../res.dart';
import 'manage_subscription_controller.dart';

class ManageSubscriptionScreen extends BaseView<ManageSubscriptionController> {
  ManageSubscriptionScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            // physics:   BouncingScrollPhysics(),
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  Res.dashboardPic,
                  fit: BoxFit.fill,
                ),
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [ColorsTheme.colPrimary, ColorsTheme.col8B0000]),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorsTheme.colWhite, width: 1)),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(children: [
                      Text(
                        "Exciting Gift".tr,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorsTheme.colWhite),
                      ),
                      Divider(
                        color: ColorsTheme.colWhite,
                        thickness: 2,
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() =>
                              GridView.builder(
                                itemCount: controller.giftData.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),

                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  print("giftdatalength ${controller.giftData.length}");
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.checkLocation();

                                            // Get.toNamed(Routes.detailsPage);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                  width: Get.width,
                                                  height: Get.width / 1.4,
                                                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),image: DecorationImage(image: NetworkImage("urlImage"),fit: BoxFit.cover)),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      image: DecorationImage(
                                                          image: NetworkImage(controller.giftData[index].giftImage!),
                                                          fit: BoxFit.cover))),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                child: Container(
                                                  width: Get.width,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                                                          bottomRight: Radius.circular(20)), color: Colors.red),
                                                  child: Center(
                                                    child: Text(
                                                      controller.giftData[index].giftName!,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style:
                                                      boldTextStyle(fontSize: dimen12, color: ColorsTheme.colWhite),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        )
                                      ],
                                    ),
                                  );
                                },
                              )),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "Terms & Conditions".tr,
                                style: regularTextStyle(fontSize: dimen16, color: ColorsTheme.colWhite)),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Get.toNamed(Routes.register);
                                  },
                                text: " For Exciting Gifts".tr,
                                style: mediumTextStyle(fontSize: dimen15, color: Colors.yellow)),
                          ])),
                        ),
                      ),
                    ])),
                Center(
                  child: InkWell(
                    onTap: () {
                      getBoostDialogDetails(context);
                      },
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [ColorsTheme.colPrimary, ColorsTheme.col8B0000]),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: ColorsTheme.colWhite, width: 1)),
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                        child: Column(children: [
                          Text(
                            "Check Your Gift".tr,
                            style: TextStyle(fontSize: 14, color: ColorsTheme.colWhite),
                          ),
                        ])),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [ColorsTheme.colPrimary, ColorsTheme.col8B0000]),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: ColorsTheme.colWhite, width: 1)),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Our Winners".tr,
                          style: regularTextStyle(fontSize: dimen20, color: ColorsTheme.colWhite),
                        ),
                      ),
                      Divider(
                        color: ColorsTheme.colWhite,
                        thickness: 2,
                      ),
                      Expanded(
                        child: Obx(() =>
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.giftWinner.length,
                                physics: ScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: ColorsTheme.colWhite,
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: ColorsTheme.colWhite, width: 1)),
                                      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                                      padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                                      child: Text(
                                        controller.giftWinner[index].winnersName ?? "",
                                        // controller.getDataModel.value.message![index]
                                        //     .winnersName
                                        //     .toString(),
                                        style: TextStyle(color: ColorsTheme.colBlack),
                                      ));
                                })),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.toNamed(Routes.detailsPage);
                    controller.checkLocation();
                    //Get.offAndToNamed(Routes.dropdownScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [ColorsTheme.colPrimary, ColorsTheme.col8B0000]),
                      /*tileMode: TileMode.decal,*/

                      border: Border.all(color: Colors.white54, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                    padding: const EdgeInsets.only(top: 11, bottom: 11),
                    child: Center(
                      child: Text(
                        "Participate Now".tr,
                        style: regularTextStyle(fontSize: dimen14, color: ColorsTheme.colWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    final Uri url = Uri.parse('https://vivorajasthan.com/diwali-bonanza-t-c');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch ');
    }
  }

  Widget menu() {
    return Container(
      color: const Color(0xFF3F5AA6),
      child: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "Continue",
          ),
        ],
      ),
    );
  }

  getBoostDialog(context) {
    showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) =>
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Card(
                    child: Container(
                      height: 200,
                      width: 450,
                      margin: const EdgeInsets.only(left: 24, right: 24),
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(color: ColorsTheme.colBlack),
                            child: Text(
                              "check_your_gift_now".tr,
                              style: semiBoldTextStyle(
                                fontSize: dimen20,
                                color: ColorsTheme.colEEAF51,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your mobile number';
                                }
                                // Add additional validation if required
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                //getBoostDialogDetails(context);
                              },
                              child: Text(
                                "Check",
                                style: regularTextStyle(
                                  fontSize: dimen12,
                                  color: ColorsTheme.col4D4D4D,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  getBoostDialogDetails(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: ColorsTheme.colWhite,
              title: Obx(() =>
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                        child: Text(
                          "Check Your Gift Now".tr,
                          textAlign: TextAlign.center,
                          style: mediumTextStyle(fontSize: 15.0, color: ColorsTheme.colBlack),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorsTheme.colPrimary, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(12))),
                          child: TextFormField(
                            controller: controller.mobileController,
                            style: regularTextStyle(fontSize: 14.0, color: ColorsTheme.colBlack),
                            keyboardType: TextInputType.phone,
                            maxLength: 12,
                            // onChanged: (text) {
                            //   controller.estimatePriceChange(text);
                            // },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: regularTextStyle(fontSize: 14.0, color: ColorsTheme.colPrimary),
                              fillColor: Colors.black,
                              hintText: "Enter Your Contact No".tr,
                              counterText: "",
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              // Get.back();
                              if (controller.mobileController.text.isNotEmpty) {
                                controller.checkYourGift();
                                CommonFunction.keyboardDismiss(context);
                              }
                            },
                            child: Container(
                              width: 115,
                              height: 33,
                              decoration: const BoxDecoration(
                                  color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(2))),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Check'.tr,
                                    style: semiBoldTextStyle(fontSize: 14.0, color: ColorsTheme.colWhite),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      controller.giftImage.value != ""
                          ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                            width: double.infinity,
                            // decoration: BoxDecoration(
                            //     border: Border.all(color: ColorsTheme.colPrimary, width: 1),
                            //     borderRadius: BorderRadius.all(Radius.circular(12))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    controller.giftMessage.value,
                                    textAlign: TextAlign.center,
                                    style: mediumTextStyle(fontSize: 15.0, color: ColorsTheme.colBlack),
                                  ),
                                ),
                                Container(
                                    width: Get.width / 1.2,
                                    height: Get.width / 2.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(controller.giftImage.value), fit: BoxFit.cover))),
                              ],
                            )),
                      )
                          : Container(),
                    ],
                  )),
            ));
  }
}

//  mobileCard(context){
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Enter Mobile Number',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 labelText: 'Mobile Number',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your mobile number';
//                 }
//                 // Add additional validation if required
//                 return null;
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

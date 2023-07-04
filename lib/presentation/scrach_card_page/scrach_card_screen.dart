import 'package:bcpl_fun_club_project/presentation/scrach_card_page/scrach_card_controller.dart';
import 'package:confetti/confetti.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:scratcher/scratcher.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/colors.theme.dart';
import '../../infrastructure/theme/text.theme.dart';

class ScratchCardScreen extends GetView<ScratchCardController> {
  const ScratchCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorsTheme.colPrimary, ColorsTheme.col8B0000])),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Text(
                "Scratch Card for Your Gift",
                style: TextStyle(
                  color: ColorsTheme.col8e8e93,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() => Scratcher(
                brushSize: 50,
                threshold: 30,
                color: Colors.green,
                image: Image.asset(
                  "assets/images/scratch_overlay.png",
                  fit: BoxFit.fill,
                ),
                onChange: (value) {
                  print("percentage $value");
                  if(value.round() == 50){
                    controller.sendGiftMessage();
                  }
                },
                onThreshold: () => controller.mainScratch.play(),
                child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(controller.giftImage.value), fit: BoxFit.cover))),

                      Column(
                        children: [
                          ConfettiWidget(
                            blastDirectionality: BlastDirectionality.explosive,
                            confettiController: controller.mainScratch,
                            particleDrag: 0.05,
                            emissionFrequency: 0.05,
                            numberOfParticles: 100,
                            gravity: 0.05,
                            shouldLoop: false,
                            colors: const [
                              Colors.green,
                              Colors.red,
                              Colors.yellow,
                              Colors.blue,
                            ],
                          ),
                          const Text(
                            "You won",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                           Text(controller.giftDetail.value.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.manageSubscription);

                  //Get.offAndToNamed(Routes.dropdownScreen);
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorsTheme.colPrimary,
                      ColorsTheme.col8B0000
                    ]),
                    /*tileMode: TileMode.decal,*/

                    border: Border.all(color: Colors.white54, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 40, right: 40, top: 80, bottom: 20),
                  padding: const EdgeInsets.only(top: 11, bottom: 11),
                  child: Center(
                    child: Text(
                      'Go To Home'.tr,
                      style: regularTextStyle(
                          fontSize: dimen14, color: ColorsTheme.colWhite),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

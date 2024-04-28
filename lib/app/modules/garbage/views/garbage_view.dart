import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myp/app/theme/text_styles.dart';

import '../controllers/garbage_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GarbageView extends GetView<GarbageController> {
  const GarbageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            backgroundColor: Colors.blueAccent,
            title: Text('Garbage', style: size20FamilyPoppinsBoldColorWhite),
            centerTitle: true,
          ),
          body: StreamBuilder<Map<String, dynamic>>(
            stream: controller.databaseRealtimeService
                .getUserDataRealtime(controller.uid.value),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              var userData = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, bottom: 0, left: 10),
                    child: Text("Check your garbage level : ",
                        style: size20FamilyPoppinsBoldColorBlack),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15, right: 5),
                    child: Divider(
                      color: Colors.grey,
                      endIndent: 150,
                      indent: 10,
                      thickness: 1.2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 80,
                    ),
                    child: Text(
                      "Keep your space tidy and fresh by staying on top of your trash levels. This helps maintain a clean and organized home.",
                      style: size17FamilyPoppinsBoldColorBlack,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 40.0,
                        animation: true,
                        percent: userData?["percentGarbage"].toDouble() / 100,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              size: 55,
                              color: controller.getProgressColor(
                                  userData?["percentGarbage"].toDouble() / 100),
                            ),
                            Text(
                              "${(userData?["percentGarbage"]).toStringAsFixed(1)}%",
                              style: size17FamilyPoppinsBoldColorBlack,
                            ),
                          ],
                        ),
                        footer: Text("Garbage level",
                            style: size17FamilyPoppinsBoldColorBlack),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: controller.getProgressColor(
                            userData?["percentGarbage"].toDouble() / 100),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.red), // Example border styling
                        borderRadius:
                            BorderRadius.circular(20), // Example border radius
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "Friendly advice :",
                                style: size17FamilyPoppinsBoldColorRed,
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              "Prevent Reaching 80% Trash Capacity",
                              style: size17NormalColorRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ));
    });
  }
}

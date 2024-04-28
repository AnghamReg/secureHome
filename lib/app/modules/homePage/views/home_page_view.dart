import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myp/app/modules/garbage/controllers/garbage_controller.dart';
import 'package:myp/app/modules/garbage/views/garbage_view.dart';
import 'package:myp/app/modules/home/controllers/home_controller.dart';
import 'package:myp/app/modules/home/views/home_view.dart';
import 'package:myp/app/modules/light/controllers/light_controller.dart';
import 'package:myp/app/modules/light/views/light_view.dart';
import 'package:myp/app/modules/speech/controllers/speech_controller.dart';
import 'package:myp/app/modules/speech/views/speech_view.dart';
import 'package:myp/app/theme/temperature_icon_helper.dart';
import 'package:myp/app/theme/text_styles.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          drawer: Drawer(
            shadowColor: Colors.white70,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.white70,
                      child: ClipOval(
                        child: Icon(
                          Icons.perm_identity,
                          size: 40,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    accountName: Text(
                      controller.pseudo.value,
                      style: size15FamilyPoppinsBoldColorWhite,
                    ),
                    // accountEmail: Text("")),
                    accountEmail: Text(
                      controller.email.value,
                      style: size10FamilyPoppinsBoldColorWhite,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Analytics',
                    style: size17FamilyPoppinsBoldColorBlack,
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  endIndent: 80,
                  indent: 10,
                  thickness: 1.2,
                ),
                ListTile(
                  title: const Text('Review home'),
                  leading: const Icon(Icons.remove_red_eye),
                  onTap: () {
                    Get.back();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Control your',
                    style: size17FamilyPoppinsBoldColorBlack,
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  endIndent: 80,
                  indent: 10,
                  thickness: 1.2,
                ),
                ListTile(
                    title: const Text('Light'),
                    leading: const Icon(Icons.lightbulb),
                    onTap: () {
                      Get.to(() => const LightView(), arguments: {
                        "uid": controller.uid.value,
                        "lightIsOn": controller.lightIsOn.value,
                      });
                      Get.put(LightController());
                    }),
                ListTile(
                    title: const Text('Garbage'),
                    leading: const Icon(Icons.delete),
                    onTap: () {
                      Get.to(() => const GarbageView(), arguments: {
                        "uid": controller.uid.value,
                      });
                      Get.put(GarbageController());
                    }),
                ListTile(
                    title: const Text('Mr Secure'),
                    leading: const Icon(Icons.mic),
                    onTap: () {
                      Get.to(() => const SpeechView(),
                          arguments: {"uid": controller.uid.value});
                      Get.put(SpeechController());
                    }),
                const Divider(
                  color: Colors.grey,
                  endIndent: 80,
                  indent: 10,
                  thickness: 1.2,
                ),
                ListTile(
                    title: const Text('Disconnect',
                        style: TextStyle(color: Colors.red)),
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      await controller.disconnect();

                      Get.offAll(() => const HomeView());
                      Get.put(HomeController());
                      Get.snackbar(
                        'Disconnected :',
                        'You have been disconnected',
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 30,
                        ),
                        duration: const Duration(seconds: 3),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }),
              ],
            ),
          ),
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.blueAccent,
            title:
                Text('Review Home', style: size20FamilyPoppinsBoldColorWhite),
            centerTitle: true,
          ),
          body: StreamBuilder<Map<String, dynamic>>(
            stream: controller.databaseRealtimeService
                .getUserDataRealtime(controller.uid.value),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 10,
                    ),
                  ),
                );
              }

              var userData = snapshot.data;
              bool garbageIsFull = userData?["percentGarbage"] == 100;
              print("userData : $userData");
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, bottom: 10),
                      child: Text(
                        'Temperature :',
                        style: size20FamilyPoppinsBoldColorBlack,
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 130, right: 130),
                        child: Column(
                          children: [
                            TemperatureIconHelper.getIcon(userData?['temp']),
                            // Replace iconType with your actual temperature icon type

                            const SizedBox(width: 10),
                            // Example horizontal spacing
                            Text(
                              '${userData?['temp']}°C',
                              // Example temperature value with degree symbol
                              style: size40FamilyPoppinsBoldColorBlack,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Today',
                                style: size15FamilyPoppinsBoldColorGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        'Additional Info :',
                        style: size20FamilyPoppinsBoldColorBlack,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 45, right: 45),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyan
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 2, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: const Offset(
                                      0, 3), // Offset from the container
                                ),
                              ],
                              border: Border.all(
                                  color:
                                      Colors.black38), // Example border styling
                              borderRadius: BorderRadius.circular(
                                  10), // Example border radius
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.water_drop,
                                  size: 60,
                                  color: Colors.cyan,
                                ),
                                // Replace iconType with your actual temperature icon type

                                const SizedBox(width: 10),
                                // Example horizontal spacing
                                Text(
                                  '${userData?['hum']}',
                                  // Example temperature value with degree symbol
                                  style: size40FamilyPoppinsBoldColorBlack,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Humidity',
                                    style: size17FamilyPoppinsBoldColorBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 45, right: 45),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.red.withOpacity(0.5), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset: const Offset(
                                    0, 3), // Offset from the container
                              ),
                            ],
                            border: Border.all(
                                color:
                                    Colors.black38), // Example border styling
                            borderRadius: BorderRadius.circular(
                                10), // Example border radius
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.local_fire_department,
                                size: 60,
                                color: Colors.red,
                              ),
                              // Replace iconType with your actual temperature icon type

                              const SizedBox(width: 10),
                              // Example horizontal spacing
                              Text(
                                '${userData?['gaz']}',
                                // Example temperature value with degree symbol
                                style: size40FamilyPoppinsBoldColorBlack,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Gaz',
                                  style: size17FamilyPoppinsBoldColorBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 10, right: 6),
                      child: Text(
                        'Quick check :',
                        style: size20FamilyPoppinsBoldColorBlack,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            //light
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => const LightView(), arguments: {
                                    "uid": controller.uid.value,
                                    "lightIsOn": controller.lightIsOn.value,
                                  });
                                  Get.put(LightController());
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 45, right: 45),
                                  decoration: BoxDecoration(
                                    color: userData?["lightIsOn"]
                                        ? Colors.white
                                        : Colors.black12,

                                    border: Border.all(
                                        color: Colors
                                            .black38), // Example border styling
                                    borderRadius: BorderRadius.circular(
                                        50), // Example border radius
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.light,
                                        size: 60,
                                        color: userData?["lightIsOn"]
                                            ? Colors.amber
                                            : Colors.black,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Light is ${userData?['lightIsOn'] ? 'on' : 'off'}',
                                          style:
                                              size17FamilyPoppinsBoldColorBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //garbage
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => const GarbageView(), arguments: {
                                    "uid": controller.uid.value,
                                  });
                                  Get.put(GarbageController());
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 25, right: 25),
                                  decoration: BoxDecoration(
                                    color: garbageIsFull
                                        ? Colors.red
                                        : Colors.white,

                                    border: Border.all(
                                        color: Colors
                                            .black38), // Example border styling
                                    borderRadius: BorderRadius.circular(
                                        50), // Example border radius
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        garbageIsFull
                                            ? Icons.delete
                                            : Icons.delete_outline_rounded,
                                        size: 60,
                                        color: garbageIsFull
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Garbage is ${userData?['percentGarbage'] == 100 ? 'full' : 'empty'}',
                                          style: garbageIsFull
                                              ? size17FamilyPoppinsBoldColorWhite
                                              : size17FamilyPoppinsBoldColorBlack,
                                        ),
                                      ),
                                    ],
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
              );
            },
          ));
    });
  }
}

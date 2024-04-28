import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myp/app/theme/text_styles.dart';

import '../controllers/light_controller.dart';

class LightView extends GetView<LightController> {
  const LightView({Key? key}) : super(key: key);

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
            title: Text('Control your light',
                style: size20FamilyPoppinsBoldColorWhite),
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                      child: Text("Friendly reminder: ",
                          style: size30FamilyPoppinsBoldColorBlack),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 90),
                      child: Text(
                        "Make it a habit to turn off lights whenever you leave a room, even if it's just for a short time.",
                        style: size17FamilyPoppinsBoldColorBlack,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Icon(Icons.lightbulb,
                        size: 200,
                        color: userData?["lightIsOn"]
                            ? Colors.amber
                            : Colors.grey),
                    ElevatedButton(
                      onPressed: () {
                        controller.switchLight();
                      },
                      child: Text(userData?["lightIsOn"]
                          ? 'Turn off the light'
                          : 'Turn on the light'),
                    ),
                  ],
                ),
              );
            },
          ));
    });
  }
}

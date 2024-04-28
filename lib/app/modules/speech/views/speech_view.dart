import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myp/app/theme/text_styles.dart';

import '../controllers/speech_controller.dart';

class SpeechView extends GetView<SpeechController> {
  const SpeechView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.redAccent,
          title: Text(
            'Talk to mr Secure',
            style: size20FamilyPoppinsBoldColorWhite,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
                child: Text(
                  "Meet your personal assistant at your fingertips! Your voice is all it takes to get things done!",
                  style: size17FamilyPoppinsBoldColorBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 40),
                child: Stack(
                  children: [
                    const Icon(Icons.person_2,
                        size: 200, color: Colors.redAccent),
                    Positioned(
                      bottom:
                          0, // Adjust this value to change the vertical position
                      child: Icon(
                          controller.isListeningMic.value == true
                              ? Icons.mic
                              : Icons.mic_off,
                          color: Colors.black,
                          size: 100),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 60),
                child: Text(
                  controller.lastWords.value.isNotEmpty
                      ? controller.lastWords.value
                      : "Tap the mic and start talking...",
                  style: size15FamilyPoppinsBoldColorGrey,
                ),
              ),
              AnimatedOpacity(
                opacity: controller.isListeningMessage.value ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: controller.isListeningMessage.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.info, color: Colors.white),
                              ),
                              Text(
                                ': ${controller.returnMessage.value}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              )

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (SpeechController.speechToText.value.isNotListening) {
              controller.startListening();
            } else {
              controller.stopListening();
            }
          },
          tooltip: 'Listen',
          child: Icon(controller.isListeningMic.value == false
              ? Icons.mic_off
              : Icons.mic),
        ),
      );
    });
  }
}

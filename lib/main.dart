import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myp/app/modules/speech/controllers/speech_controller.dart';

import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  initializeFirebaseAndRunApp();
}

void initializeFirebaseAndRunApp() async {
  Get.lazyPut<SpeechController>(
    () {
      SpeechController speechController = SpeechController();
      speechController.initSpeech();
      return speechController;
    },
  );
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "secureHouse",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
    ),
  );
}

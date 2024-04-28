import 'package:get/get.dart';

import '../controllers/speech_controller.dart';

class SpeechBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeechController>(
      () => SpeechController(),
    );
  }
}

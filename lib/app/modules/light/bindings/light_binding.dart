import 'package:get/get.dart';

import '../controllers/light_controller.dart';

class LightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LightController>(
      () => LightController(),
    );
  }
}

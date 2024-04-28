import 'package:get/get.dart';

import '../controllers/garbage_controller.dart';

class GarbageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GarbageController>(
      () => GarbageController(),
    );
  }
}

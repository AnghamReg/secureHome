import 'package:get/get.dart';
import 'package:myp/app/modules/homePage/controllers/home_page_controller.dart';
import 'package:myp/app/services/database_realtime_service.dart';

class LightController extends GetxController {
  Rx<String> uid = "".obs;
  DatabaseRealtimeService databaseRealtimeService = DatabaseRealtimeService();

  @override
  void onInit() {
    super.onInit();
    uid.value = Get.arguments["uid"];
  }

  Future _changeLight() async {
    await databaseRealtimeService.changeLight(uid.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    Get.back();
  }

  Future switchLight() async {
    await _changeLight();
  }
}

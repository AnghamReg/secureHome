import 'package:get/get.dart';
import 'package:myp/app/services/auth_service.dart';
import 'package:myp/app/services/database_realtime_service.dart';

class HomePageController extends GetxController {
  Rx<String> uid = "".obs;
  Rx<String> pseudo = "".obs;
  Rx<String> email = "".obs;
  Rx<bool> lightIsOn = false.obs;
  AuthService authService = AuthService();
  DatabaseRealtimeService databaseRealtimeService = DatabaseRealtimeService();

  @override
  void onInit() {
    super.onInit();
    uid.value = Get.arguments['uid'];
    print("uid : ${uid.value}");
    email.value = Get.arguments['email'];
    _getUserData();
  }

  void _getUserData() async {
    var userData = await databaseRealtimeService.getUserDataNew(uid.value);
    pseudo.value = userData['pseudo'];
    print("pseudo is : ${userData['pseudo']}");
  }

  Future disconnect() async {
    return await authService.signOut();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

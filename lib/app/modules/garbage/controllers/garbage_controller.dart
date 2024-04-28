import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myp/app/services/database_realtime_service.dart';

class GarbageController extends GetxController {
  final count = 0.obs;
  Rx<String> uid = "".obs;
  DatabaseRealtimeService databaseRealtimeService = DatabaseRealtimeService();

  Color getProgressColor(double percent) {
    if (percent >= 0.0 && percent < 0.4) {
      // Green for 0% to 40%
      return Colors.green;
    } else if (percent >= 0.4 && percent < 0.7) {
      // Amber for 40% to 70%
      return Colors.amber;
    } else {
      // Red for 70% to 100%
      return Colors.red;
    }
  }

  @override
  void onInit() {
    uid.value = Get.arguments['uid'];
    super.onInit();
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

  void increment() => count.value++;
}

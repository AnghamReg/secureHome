import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myp/app/entities/user_data.dart';
import 'package:myp/app/services/auth_service.dart';

class HomeController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  Rx<String> errorEmail = "".obs;
  final TextEditingController passwordController = TextEditingController();
  Rx<String> errorPassword = "".obs;
  Rx<String> errorLogin = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void _validateEmail() {
    if (emailController.text.isEmpty) {
      errorEmail.value = "Please fill Email";
    } else {
      errorEmail.value = "";
    }
  }

  void _validatePassword() {
    if (passwordController.text.isEmpty) {
      errorPassword.value = "Please fill Password";
    } else {
      errorPassword.value = "";
    }
  }

  Future<UserApp?> login() async {
    _validateEmail();
    _validatePassword();
    if (errorPassword.isEmpty && errorEmail.isEmpty) {
      dynamic res = await _authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      print("res login = $res");
      return res;
    }
    return null;
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

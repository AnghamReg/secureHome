import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myp/app/entities/user_data.dart';
import 'package:myp/app/services/auth_service.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  Rx<String> errorEmail = "".obs;
  final TextEditingController passwordController = TextEditingController();
  Rx<String> errorPassword = "".obs;
  final TextEditingController pseudoController = TextEditingController();
  Rx<String> errorPseudo = "".obs;
  final AuthService _authService = AuthService();

  void _validatePseudo() {
    if (pseudoController.text.isEmpty) {
      errorPseudo.value = "Please fill Pseudo";
    } else {
      errorPseudo.value = "";
    }
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

  Future<UserApp?> validateSignUp() async {
    _validatePseudo();
    _validateEmail();
    _validatePassword();
    if (errorPassword.isEmpty && errorPseudo.isEmpty && errorEmail.isEmpty) {
      dynamic res = await _authService.registerWithEmailAndPassword(
          emailController.text, passwordController.text, pseudoController.text);
      return res;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
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

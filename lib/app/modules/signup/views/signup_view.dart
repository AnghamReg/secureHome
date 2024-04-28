import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myp/app/entities/user_data.dart';
import 'package:myp/app/modules/home/controllers/home_controller.dart';
import 'package:myp/app/modules/home/views/home_view.dart';
import 'package:myp/app/modules/homePage/controllers/home_page_controller.dart';
import 'package:myp/app/modules/homePage/views/home_page_view.dart';
import 'package:myp/app/theme/text_styles.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/SecureHomeLogo.png',
                  width: 120,
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'SecureHome',
                    style: size20FamilyPoppinsBoldColorBlueAccent,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 700,
                  height: 490,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'SIGNUP',
                        style: size30FamilyPoppinsBoldColorBlack,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Create a new account to continue",
                        style: size15FamilyPoppinsBoldColorGrey,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextField(
                        controller: controller.pseudoController,
                        cursorColor: Colors.blueAccent,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Pseudo',
                          icon: Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 110),
                      child: Text(
                        controller.errorPseudo.value,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: TextField(
                        controller: controller.emailController,
                        cursorColor: Colors.blueAccent,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 120),
                      child: Text(
                        controller.errorEmail.value,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: TextField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 90),
                      child: Text(
                        controller.errorPassword.value,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ?',
                          style: size15FamilyPoppinsBoldColorGrey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              Get.off(const HomeView());
                              Get.put(HomeController());
                            },
                            child: Text(
                              'Login',
                              style: size15FamilyPoppinsBoldColorGreyUnderLined,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          UserApp? res = await controller.validateSignUp();
                          if (res != null) {
                            Get.off(const HomePageView(), arguments: {
                              "uid": res.uid,
                            });
                            Get.put(HomePageController());
                            Get.snackbar(
                              "Account created successfully :",
                              "Keep your home secure with SecureHome!",
                              snackPosition: SnackPosition.BOTTOM,
                              icon: const Icon(Icons.home),
                              backgroundColor: Colors.blueAccent,
                              colorText: Colors.white,
                              borderWidth: 2,
                              duration: const Duration(seconds: 4),
                            );
                          }
                        },
                        child: Text(
                          'Sign up',
                          style: size15FamilyPoppinsBoldColorWhite,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

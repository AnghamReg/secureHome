import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myp/app/modules/homePage/controllers/home_page_controller.dart';
import 'package:myp/app/modules/homePage/views/home_page_view.dart';
import 'package:myp/app/theme/text_styles.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

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
                  height: 400,
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
                        'LOGIN',
                        style: size30FamilyPoppinsBoldColorBlack,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 20, right: 20),
                      child: TextField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          focusColor: Colors.blueAccent,
                          hoverColor: Colors.blueAccent,
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
                      padding: const EdgeInsets.only(right: 130),
                      child: Text(
                        controller.errorEmail.value,
                        style: const TextStyle(color: Colors.red),
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
                      padding: const EdgeInsets.only(right: 100),
                      child: Text(
                        controller.errorPassword.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    Text(
                      controller.errorLogin.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          final res = await controller.login();
                          if (res != null) {
                            controller.errorLogin.value = "";
                            Get.lazyPut<HomePageController>(
                              () {
                                HomePageController homePageController =
                                    HomePageController();
                                return homePageController;
                              },
                            );
                            // Get.put(HomePageController());
                            Get.off(const HomePageView(), arguments: {
                              "uid": res.uid,
                              "email": controller.emailController.text
                            });

                            Get.snackbar(
                              "Welcome :",
                              "Keep your home secure with SecureHome!",
                              snackPosition: SnackPosition.BOTTOM,
                              icon: const Icon(Icons.home),
                              backgroundColor: Colors.blueAccent,
                              colorText: Colors.white,
                              borderWidth: 2,
                              duration: const Duration(seconds: 4),
                            );
                          } else if (controller
                                  .emailController.text.isNotEmpty &&
                              controller.passwordController.text.isNotEmpty) {
                            controller.errorLogin.value =
                                "Email or password invalid";
                          }
                        },
                        child: Text(
                          'Login',
                          style: size15FamilyPoppinsBoldColorWhite,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No account yet ?',
                          style: size15FamilyPoppinsBoldColorGrey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              Get.offNamed('/signup');
                            },
                            child: Text(
                              'Sign Up',
                              style: size15FamilyPoppinsBoldColorGreyUnderLined,
                            ),
                          ),
                        ),
                      ],
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

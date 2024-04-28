import 'package:get/get.dart';

import '../modules/garbage/bindings/garbage_binding.dart';
import '../modules/garbage/views/garbage_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homePage/bindings/home_page_binding.dart';
import '../modules/homePage/views/home_page_view.dart';
import '../modules/light/bindings/light_binding.dart';
import '../modules/light/views/light_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/speech/bindings/speech_binding.dart';
import '../modules/speech/views/speech_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPEECH,
      page: () => const SpeechView(),
      binding: SpeechBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.LIGHT,
      page: () => const LightView(),
      binding: LightBinding(),
    ),
    GetPage(
      name: _Paths.GARBAGE,
      page: () => const GarbageView(),
      binding: GarbageBinding(),
    ),
  ];
}

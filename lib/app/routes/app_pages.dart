import 'package:get/get.dart';

import '../modules/blue/bindings/blue_binding.dart';
import '../modules/blue/views/blue_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/serve/bindings/serve_binding.dart';
import '../modules/serve/views/serve_view.dart';

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
      name: _Paths.BLUE,
      page: () => const BlueView(),
      binding: BlueBinding(),
    ),
    GetPage(
      name: _Paths.SERVE,
      page: () => const ServeView(),
      binding: ServeBinding(),
    ),
  ];
}

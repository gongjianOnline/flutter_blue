import 'package:get/get.dart';

import '../controllers/blue_controller.dart';

class BlueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlueController>(
      () => BlueController(),
    );
  }
}

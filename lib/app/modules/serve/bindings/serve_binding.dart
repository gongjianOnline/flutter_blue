import 'package:get/get.dart';

import '../controllers/serve_controller.dart';

class ServeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServeController>(
      () => ServeController(),
    );
  }
}

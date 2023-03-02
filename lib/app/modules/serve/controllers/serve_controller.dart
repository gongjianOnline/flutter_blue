import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import "../../../blue/broadcast.dart";

class ServeController extends GetxController {
  //TODO: Implement ServeController

  RxString data = ''.obs;
  final TextEditingController controller = TextEditingController();
  final BluetoothServer _server = BluetoothServer(
    serviceUuid: '0000abcd-0000-1000-8000-00805f9b34fb',
    characteristicUuid: '0000abcd-0000-1000-8000-00805f9b34fc',
  );


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
  
  @override
  void dispose() {
    _server.stop(); // 停止服务
    super.dispose();
  }

  // 开启服务
  void startServer() async{
    await _server.start();
    data.value = "开启服务";
  }
  // 停止服务
  void stopServer() async{
    await _server.stop();
    data.value = "停止服务";
  }
  // 发送消息
  void sendData()async{
    _server.broadcast(controller.text);
  }

  
}

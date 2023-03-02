import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import "../../../blue/client.dart";

class BlueController extends GetxController {
  
  RxString titleName = "连接服务端蓝牙".obs;

  late BluetoothClient client;
  
  @override
  void onInit() {
    super.onInit();
    BluetoothClient client = BluetoothClient(
      device: Get.arguments["device"],
      serviceUuid: '0000abcd-0000-1000-8000-00805f9b34fb',
      characteristicUuid: '0000abcd-0000-1000-8000-00805f9b34fc',
    );
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
    super.dispose();
  }

  createFun()async{
    await client.connect();
    // 监听输出流接受服务端发送的数据
    client.output.listen((data) {
      String receivedData = utf8.decode(data);
      print('Received data: $receivedData');
    });
  }

  sendFun(){
    client.send('Hello, server!');
  }

  disConnect()async{
    await client.disconnect();
    print("断开连接");
  }







}


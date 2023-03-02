import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class BlueController extends GetxController {
  //TODO: Implement BlueController

  RxString titleName = "连接蓝牙".obs;
  var device = Get.arguments["device"];
  RxBool isDesponse = false.obs;
  RxString deviceState = "尝试连接".obs;
  // late Rx<BluetoothCharacteristic > mCharacteristic;
  late BluetoothCharacteristic mCharacteristic;


  @override
  void onInit() {
    super.onInit();
    print("打印需要链接的蓝牙设备");
    print(Get.arguments);
    print(Get.arguments);
    // 连接蓝牙
    device.connect();
    device.state.listen((state){
      if(isDesponse.value == false){
        print("蓝牙状态被监听");
        if (state == BluetoothDeviceState.connected) {
          print("蓝牙状态被监听---连接成功");
          deviceState.value = '连接成功';
          discoverServices();
        } else if (state == BluetoothDeviceState.connecting) {
          print("蓝牙状态被监听---连接中");
          deviceState.value = '连接中';
        } else if (state == BluetoothDeviceState.disconnected) {
          print("蓝牙状态被监听---蓝牙断开");
          deviceState.value = '蓝牙已断开';
        }
      }
    });


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
    isDesponse.value=true;
    device.disconnect();
    // TODO: implement dispose
    super.dispose();
  }

  // 发现服务
  discoverServices() async {
    List<BluetoothService> services = await device.discoverServices();
    // 遍历服务
    services.forEach((service) {
      print("-------");
      print(service);
      // print('服务 UUID: ${service.uuid}');
      // service.characteristics.forEach((characteristic) {
      //   print('特征 UUID: ${characteristic.uuid}');
      //   print(characteristic);
      //   var properties = characteristic.properties;
      //   // bool isReadable = properties.contains(CharacteristicProperties.read);
      //   // bool isWritable = properties.contains(CharacteristicProperties.write);
      // });

      // // // 便利服务下面的读写特征值
      // service.characteristics.forEach((item){

      //   // if(item.properties.read==true && item.properties.write==true){
      //     // if(item.properties.notify == true && item.properties.write==true){
      //       print(item.uuid == "00000007-09da-4bed-9652-f507366fcfc5");
      //   if(item.uuid.toString() == "00000007-09da-4bed-9652-f507366fcfc5"){
      //     print("选中的对象");
      //     print(item);
      //     mCharacteristic = item;
      //     dataCallbackBle();
      //   }
      // });
    });
  }

  // 读取蓝牙模块传输的信息
  dataCallbackBle()async{
    await mCharacteristic.setNotifyValue(true);
    
    mCharacteristic.value.listen((value){
      if (value == null) {
        print("我是蓝牙返回数据 - 空！！");
        return;
      }
      print(value);
      print(String.fromCharCodes(value));  //表示Ascii转换成字符串
      print(AsciiDecoder().convert(value));
    });
  }




}


import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:app_settings/app_settings.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  FlutterBluePlus flutterBlue  = FlutterBluePlus.instance;
  RxBool isBleOn = false.obs;
  RxList listData = [].obs;
  

  @override
  void onInit() {
    super.onInit();
    flutterBlue.state.listen((state){
      if(state == BluetoothState.on){
        print("蓝牙状态开启");
        isBleOn.value = true;
         //申请蓝牙权限
        requestPermission();
      }else if(state == BluetoothState.off){
        print("蓝牙状态关闭");
        isBleOn.value = false;
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
  
  // 动态权限
  requestPermission() async {
    if (await Permission.bluetooth.request().isGranted) {
      // 已经获得蓝牙权限
      print("已经获得蓝牙权限");
    } else {
      print("拒绝了蓝牙权限请求");
    }
    // bool hasBluetoothPermission = await requestBluePermission();
    // if(hasBluetoothPermission){
    //   print("蓝牙权限申请通过");
    //   // 监听扫描结果
    //   flutterBlue.scanResults.listen((results) {
    //     listData.value = [];
    //     for(ScanResult key in results){
    //       var device = key.device;
    //       if(device.name.isNotEmpty){
    //         if(listData.value.indexOf(device) == -1){
    //           listData.add(device);
    //         }
    //       }
    //     }
    //   });
    //   this.scanDevice();
    // }else{
    //   print("蓝牙权限申请不通过");
    // }
    // return hasBluetoothPermission;
  }

  // 申请蓝牙权限
  //申请蓝牙权限  授予定位权限返回true， 否则返回false
  // Future<bool> requestBluePermission() async {
  //   if (await Permission.bluetooth.isGranted) {
  //     return true;
  //   } else {
  //     var result = await [Permission.bluetooth].request();
  //     print("进入了这个东西了吗？ ${result}");
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }else{
  //       return false;
  //     }
  //   }
  // }

  // 扫描设备
  scanDevice()async{
    if(isBleOn.value){
      // 请求蓝牙扫描权限 兼容Android12
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
      if (statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
          statuses[Permission.bluetoothConnect] == PermissionStatus.granted) {
        // 进行蓝牙扫描
        flutterBlue.startScan(timeout: Duration(seconds: 10));
        // 停止之前的蓝牙
        if (await flutterBlue.isOn) {
          try {
            await flutterBlue.stopScan(); // 停止之前的扫描
            await flutterBlue.startScan(
              timeout: Duration(seconds: 10),
              withServices: [], // 你可以添加需要搜索的服务UUID
            );
          } catch (e) {
            print(e.toString());
          }
        }
      } else {
        print("用户拒绝了权限请求");
      }
      
    }
  }

}

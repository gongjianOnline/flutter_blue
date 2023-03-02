import 'package:get/get.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  FlutterBlue flutterBlue = FlutterBlue.instance;
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
        // // 扫描设备
        // scanDevice();
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
    bool hasBluetoothPermission = await requestBluePermission();
    print(hasBluetoothPermission);
    if(hasBluetoothPermission){
      print("蓝牙权限申请通过");
      // 监听扫描结果
      flutterBlue.scanResults.listen((results) {
        listData.value = [];
        for(ScanResult key in results){
          var device = key.device;
          if(device.name.isNotEmpty){
            if(listData.value.indexOf(device) == -1){
              listData.add(device);
            }
          }
        }
      });
      this.scanDevice();
    }else{
      print("蓝牙权限申请不通过");
    }
    return hasBluetoothPermission;
  }

  // 申请蓝牙权限
  //申请蓝牙权限  授予定位权限返回true， 否则返回false
  Future<bool> requestBluePermission() async {
    //获取当前的权限
    if (await Permission.bluetooth.isGranted) {
      return true;
    } else {
      var result = await Permission.bluetooth.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

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
        
      } else {
        print("用户拒绝了权限请求");
      }
      
    }
  }

}

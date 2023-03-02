import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothClient {
  // 服务端蓝牙设备的名称
  // final String deviceName;

  // BluetoothDevice对象
  BluetoothDevice? device;

  // 蓝牙服务UUID
  final String serviceUuid;

  // 蓝牙特征UUID
  final String characteristicUuid;

  // FlutterBluePlus实例
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  // BluetoothCharacteristic对象
  BluetoothCharacteristic? characteristic;

  // 输出流
  late Stream<List<int>> output;

  // 连接状态流
  Stream<BluetoothDeviceState>? state;

  // 构造函数
  BluetoothClient({
    required this.device,
    required this.serviceUuid,
    required this.characteristicUuid,
  });

  // 开始连接服务端
  Future<void> connect() async {
    // // 查找设备
    // device = await flutterBlue.scanForDevices(
    //   timeout: const Duration(seconds: 5),
    //   withServices: [serviceUuid],
    //   scanMode: ScanMode.lowLatency,
    // ).firstWhere((device) => device.name == deviceName);

    // 连接设备
    await device!.connect();

    // 获取服务
    List<BluetoothService> services = await device!.discoverServices();
    BluetoothService service = services.firstWhere((s) => s.uuid.toString() == serviceUuid);

    // 获取特征
    characteristic =
        service.characteristics.firstWhere((c) => c.uuid.toString() == characteristicUuid);

    // 监听特征变化
    output = characteristic!.value;

    // 连接状态流
    state = device!.state;
  }

  // 断开连接
  Future<void> disconnect() async {
    // 断开连接
    await device!.disconnect();

    // 清空状态
    device = null;
    characteristic = null;
  }

  // 发送数据到服务端
  void send(String data) {
    // 将数据发送到服务端
    characteristic?.write(utf8.encode(data));
  }
}

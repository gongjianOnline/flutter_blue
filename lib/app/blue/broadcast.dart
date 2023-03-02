import 'dart:async';
import 'dart:convert';
import 'dart:io';

class BluetoothServer {
  // 蓝牙服务UUID
  final String serviceUuid;

  // 蓝牙特征UUID
  final String characteristicUuid;

  // 服务端Socket
  ServerSocket? _serverSocket;

  // 客户端Socket列表
  List<Socket> _clientSockets = [];

  // 构造函数
  BluetoothServer({required this.serviceUuid, required this.characteristicUuid});

  // 启动蓝牙服务
  Future<void> start() async {
    try {
      // 创建服务端Socket
      _serverSocket = await ServerSocket.bind(
        InternetAddress.anyIPv6,
        0, // 0表示系统分配随机未使用的端口号
        v6Only: true,
        shared: true, // 允许多个应用程序绑定同一端口
      );

      // 打印服务端信息
      print('Bluetooth server started at ${_serverSocket!.address.host}:${_serverSocket!.port}');

      // 监听客户端连接请求
      _serverSocket!.listen((socket) {
        // 添加客户端Socket到列表中
        _clientSockets.add(socket);

        // 打印客户端信息
        print('Client connected from ${socket.remoteAddress.address}:${socket.remotePort}');

        // 监听客户端数据
        socket.listen((data) {
          // 打印接收到的数据
          print('Received: ${utf8.decode(data)}');

          // 广播数据到所有客户端
          for (Socket clientSocket in _clientSockets) {
            if (clientSocket != socket) {
              clientSocket.add(data);
            }
          }
        }, onError: (error, stackTrace) {
          // 客户端断开连接
          print('Client disconnected: $error');
          _clientSockets.remove(socket);
        }, onDone: () {
          // 客户端断开连接
          print('Client disconnected');
          _clientSockets.remove(socket);
        });
      });
    } catch (e) {
      print('Error starting Bluetooth server: $e');
    }
  }

  // 停止蓝牙服务
  Future<void> stop() async {
    // 关闭所有客户端连接
    for (Socket clientSocket in _clientSockets) {
      clientSocket.destroy();
    }
    _clientSockets.clear();

    // 关闭服务端Socket
    await _serverSocket?.close();
    _serverSocket = null;

    // 打印服务端已停止
    print('Bluetooth server stopped:服务端停止');
  }

  // 广播数据到所有客户端
  void broadcast(String data) {
    for (Socket clientSocket in _clientSockets) {
      clientSocket.add(utf8.encode(data));
    }
  }

}

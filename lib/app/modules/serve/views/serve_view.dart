import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/serve_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import "../../../blue/broadcast.dart";


class ServeView extends GetView<ServeController> {
  const ServeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: const Text('ServeView'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Text("${controller.data}"),
              ElevatedButton(
                onPressed: (){
                  controller.startServer();
                }, 
                child: const Text("开启服务")
              ),
              ElevatedButton(
                onPressed: (){
                  controller.stopServer();
                }, 
                child: const Text("停止服务")
              ),
              TextField(
                controller: controller.controller,
              ),
              ElevatedButton(
                onPressed: (){
                  controller.sendData();
                }, 
                child: const Text("发送")
              ),


            ],
          )
        ),
      );
    });
  }
}

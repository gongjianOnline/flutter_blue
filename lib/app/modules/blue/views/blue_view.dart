import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/blue_controller.dart';

import 'package:flutter_blue/flutter_blue.dart';

class BlueView extends GetView<BlueController> {
  const BlueView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        appBar: AppBar(
          title: Text(controller.titleName.value),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                controller.deviceState.value,
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: ()async{
                  final command = "111222";
                  final convertedCommand = AsciiEncoder().convert(command);
                  await controller.mCharacteristic.write(convertedCommand);
                }, 
                child: Text("send")
              )
            ],
          )
        ),
      )
    );
  }
}

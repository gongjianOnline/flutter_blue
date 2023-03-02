import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/blue_controller.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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
              ElevatedButton(
                onPressed: ()async{
                  controller.disConnect();
                }, 
                child: Text("send")
              ),
              ElevatedButton(
                onPressed: ()async{
                  controller.sendFun();
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

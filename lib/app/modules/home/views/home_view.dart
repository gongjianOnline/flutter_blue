import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            controller.scanDevice();
          },
          child: Icon(Icons.update_outlined),
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('HomeView ${controller.isBleOn.value}'),
              TextButton(
                onPressed: (){
                  Get.toNamed("/blue");
                }, 
                child: const Text(
                  "连接蓝牙",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  ),
                )
              )
            ],
          ),
          centerTitle: true,
        ),
        body:Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children:controller.listData.map((item){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${item.name}"),
                    ElevatedButton(
                      onPressed: (){
                        Get.toNamed("/blue",arguments: {"device":item});
                      }, 
                      child: Text("连接")
                    )
                  ],
                );
              }).toList()
            ),
          )
        ),
      );
    });
  }
}

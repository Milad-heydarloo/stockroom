import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DDControler extends GetxController {
  String s = '-';

  String getString() {
    return s;
  }

  void toggleString() {
    s = (s == '-') ? '+' : '-'; // تغییر مقدار s
    update(['id']); // به‌روزرسانی ویجت با شناسه 'id'
  }
}

void main() {
  Get.put(DDControler());
  runApp(Hjh());
}

class Hjh extends StatefulWidget {
  const Hjh({Key? key}) : super(key: key);

  @override
  State<Hjh> createState() => _HjhState();
}

class _HjhState extends State<Hjh> {
  DDControler ddControler = Get.find<DDControler>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GetBuilder<DDControler>(
                id: 'id',
                builder: (controller) {
                  return Text('${ddControler.getString()}');
                },
              ),
              IconButton(
                onPressed: () {
                  ddControler.toggleString(); // تغییر مقدار s با کلیک بر روی دکمه
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

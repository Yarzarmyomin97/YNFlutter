import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yn_flutter/controllers/counter_controller.dart';
import 'package:yn_flutter/pages/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'YN Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController c = Get.put(CounterController());

    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Column(
          children: [
            ElevatedButton(
                child: const Text("Go to Other"),
                onPressed: () {
                  Get.to(const SecondPage());
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: c.increment));
  }
}

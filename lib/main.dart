import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';

import 'nav.dart';
import 'screens/controller/show_controller.dart';
import 'screens/show_screen.dart';
import 'screens/submit_page.dart';

void main() {
  Get.put(ShowController());
  runApp(const MyApp());
  StatusBarUtil.transparent();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToastApp(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff061a3f),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isDesktop) {
      return const ShowScreen();
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: [
              const ShowScreen(),
              const SubmitPage(),
            ][index],
          ),
          Nav(
            value: index,
            onTap: (value) {
              index = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

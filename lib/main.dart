import 'package:flutter/material.dart';

import 'nav.dart';
import 'screens/show_screen.dart';
import 'submit_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff061a3f),
      ),
      home: HomePage(),
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

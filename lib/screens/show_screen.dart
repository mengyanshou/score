import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:score/gen.dart';
import 'package:score/screens/controller/show_controller.dart';

Map<String, String> logoMap = {
  '成都锦城学院': "成都锦城学院.png",
  '武汉大学': "武汉大学.png",
};

String getLogo(String name) {
  // if (logoMap.containsKey(name)) {
  //   return 'assets/logos/${logoMap[name]!}';
  // }
  return 'assets/logos/$name.png';
}

class ShowScreen extends StatefulWidget {
  const ShowScreen({Key? key}) : super(key: key);

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          header(),
          body(),
        ],
      ),
    );
  }

  Widget body() {
    return GetBuilder<ShowController>(builder: (controller) {
      List<Score> scores = controller.scores;
      return Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Transform.translate(
            offset: Offset(0.0, -32),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (scores.length > 1) three(scores[1]),
                      if (scores.isNotEmpty)
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: three(scores[0]),
                        ),
                      if (scores.length > 2) three(scores[2]),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              // color: Colors.amberAccent,
                              width: 40,
                              child: Center(child: Text('排名')),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 140,
                              child: Container(
                                // color: Colors.blue,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('院校|队伍'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Center(child: Text('第一轮')),
                            ),
                            SizedBox(
                              width: 60,
                              child: Center(child: Text('第二轮')),
                            ),
                            SizedBox(
                              width: 60,
                              child: Center(child: Text('总分')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.separated(
                      itemCount: scores.length,
                      itemBuilder: (context, index) {
                        Score score = scores[index];
                        return item(index, score);
                      },
                      padding: EdgeInsets.zero,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Container item(int index, Score score) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Container(
                  // color: Colors.yellow,
                  child: Center(
                    child: Builder(builder: (context) {
                      Color color = Color(0xff333333);
                      if (index < 3) {
                        color = Color(0xffe77567);
                      }
                      return Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                // color: Colors.red,
                width: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(getLogo(score.school_name!)),
                      radius: 16.0,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            score.sub_name!,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            score.school_name!,
                            style: TextStyle(
                              color: Color(0xff333333).withOpacity(0.8),
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 60,
                child: Center(
                  child: Text(
                    '${score.score1!}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Center(
                  child: Text(
                    '${score.score2!}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Center(
                  child: Text(
                    '${score.score1! + score.score2!}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget three(Score score) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Image.asset(
            getLogo(score.school_name!),
            width: 64,
          ),
          SizedBox(
            height: 12,
          ),
          Text('${score.school_name}'),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgroundImage.png'),
          fit: BoxFit.fill,
        )
      ),
      width: double.infinity,
      // color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: const [
            Text(
              'ENJOY AI Master 2022西部选拔赛',
              style: TextStyle(fontSize: 16.0,color: Colors.white),
            ),
            SizedBox(height: 10,),
            Text(
              '2022全国大学生智能汽车竞赛',
              style: TextStyle(fontSize: 32.0,color: Colors.white),
            ),
            SizedBox(height: 10,),
            Text(
              '百度智慧交通赛项',
              style: TextStyle(fontSize: 16.0,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

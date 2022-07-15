import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

import 'gen.dart';

List<String> schools = [
  '厦门工学院',
  '厦门理工学院',
  '华南师范大学',
  '哈尔滨工业大学',
  '中山大学',
  '成都锦城学院',
];

class SubmitPage extends StatefulWidget {
  const SubmitPage({Key? key}) : super(key: key);

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  // 比赛轮数
  int gameIndex = 1;
  RestClient restClient = RestClient(
    Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print(options.uri);
            print(options.extra);
            handler.next(options);
          },
        ),
      ),
  );
  Score score = Score(
    score1: 0,
    score2: 0,
    school_name: '',
    sub_name: '',
    group: 0,
  );

  int curScore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f9),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title('学校'),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      score.school_name = await showMenu<String>(
                        context: context,
                        position: RelativeRect.fill,
                        items: <PopupMenuEntry<String>>[
                          for (String school in schools)
                            PopupMenuItem(
                              child: Text(school),
                              value: school,
                            ),
                        ],
                      );
                      print(score.school_name);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffe8e9ee),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(score.school_name ?? ''),
                    ),
                  ),
                  const SizedBox(height: 10),
                  title('组数'),
                  const SizedBox(height: 10),
                  title('比赛轮数'),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: CheckContainer(
                            groupValue: gameIndex,
                            value: 1,
                            onChanged: (value) {
                              gameIndex = value;
                              setState(() {});
                            },
                            child: Text(
                              '第一轮',
                              style: TextStyle(
                                fontSize: 14.w,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CheckContainer(
                            groupValue: gameIndex,
                            value: 2,
                            onChanged: (value) {
                              gameIndex = value;
                              setState(() {});
                            },
                            child: Text(
                              '第二轮',
                              style: TextStyle(
                                fontSize: 14.w,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title('录入人'),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color(0xffe8e9ee),
                        filled: true,
                      ),
                      onChanged: (value) {
                        score.sub_name = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  title('此轮分数'),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color(0xffe8e9ee),
                        filled: true,
                      ),
                      onChanged: (value) {
                        curScore = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureWithScale(
                onTap: () async {
                  // print(await RestClient(Dio()).getScores());
                  if (gameIndex == 0) {
                    score.score1 = curScore;
                  } else {
                    score.score2 = curScore;
                  }
                  score.time = DateTime.now().millisecond;
                  try {
                    Score res = await restClient.createScore(score);
                  } on DioError catch (e) {
                    print(e.error);
                    print(e.message);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: const Text(
                      '提交',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text title(String data) {
    return Text(
      data,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

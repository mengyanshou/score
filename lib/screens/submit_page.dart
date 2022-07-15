import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

import '../gen.dart';

class Organization {
  Organization(this.name, this.schollName);
  final String name;
  final String schollName;
}

List<Organization> groups = [
  Organization('深蓝黄金矿工队', '华南师范大学'),
];

class SubmitPage extends StatefulWidget {
  const SubmitPage({Key? key}) : super(key: key);

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  // 比赛轮数
  int gameIndex = 1;
  // 组数
  int groupIndex = 1;
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
    school_name: groups.first.schollName,
    sub_name: '',
    group: 0,
  );

  int curScore = 0;

  void changeOrg() async {
    String? name = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(10, 10, 10, 10),
      items: <PopupMenuEntry<String>>[
        for (Organization organization in groups)
          PopupMenuItem(
            child: Text(organization.schollName),
            value: organization.schollName,
          ),
      ],
    );
    if (name != null) {
      score.school_name = name;
    }
    print(score.school_name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('队伍'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            changeOrg();
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
                        SizedBox(
                          width: 10,
                        ),
                        GestureWithScale(
                          onTap: () {
                            changeOrg();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: 100,
                            height: 36,
                            child: Center(
                              child: Text(
                                '更改队伍',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    title('组数'),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: CheckContainer(
                              groupValue: groupIndex,
                              value: 1,
                              onChanged: (value) {
                                groupIndex = value;
                                setState(() {});
                              },
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: CheckContainer(
                              groupValue: groupIndex,
                              value: 2,
                              onChanged: (value) {
                                groupIndex = value;
                                setState(() {});
                              },
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: CheckContainer(
                              groupValue: groupIndex,
                              value: 3,
                              onChanged: (value) {
                                groupIndex = value;
                                setState(() {});
                              },
                              child: Text(
                                '3',
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
                    score.group = groupIndex;
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
      ),
    );
  }

  Text title(String data) {
    return Text(
      data,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CheckContainer extends StatelessWidget {
  const CheckContainer({
    Key? key,
    this.onChanged,
    this.value,
    this.groupValue,
    this.child,
  }) : super(key: key);

  final void Function(int value)? onChanged;
  final int? value;
  final int? groupValue;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bool isCheck = value == groupValue;
    return Container(
      decoration: isCheck
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2.w,
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              border: Border.all(
                color: Colors.transparent,
                width: 2.w,
              ),
            ),
      padding: EdgeInsets.all(4.w),
      child: GestureDetector(
        onTap: () {
          onChanged?.call(value!);
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffe8e9ee),
            borderRadius: BorderRadius.circular(12.w),
            // border: Border.all(
            //   color: Colors.grey.withOpacity(0.2),
            //   width: 2.w,
            // ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.w,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

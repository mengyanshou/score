import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

import '../gen.dart';

class Team {
  Team(this.name, this.schollName);
  final String name;
  final String schollName;
}

List<Team> groups = [
  Team('深蓝黄金矿工队', '华南师范大学'),
  Team('华工奔雷队', '华南理工大学'),
  Team('深蓝智航队', '广东海洋大学'),
  Team('老司机', '中山大学'),
  Team('广师AI视觉', '广东技术师范大学'),
  Team('冰糖葫芦', '桂林理工大学'),
  Team('HPU-SR', '河南理工大学'),
  Team('五只老虎跑得快', '河南理工大学'),
  Team('薄荷棉花糖队', '商丘师范学院'),
  Team('华中科技大学百度智慧交通一队', '华中科技大学'),
  Team('没烦恼', '湖北科技学院'),
  Team('乌拉队', '湖北科技学院'),
  Team('WIT', '武汉工程大学'),
  Team('CTGU2022', '三峡大学'),
  Team('烽火戏诸侯', '湖北民族大学'),
  Team('扶摇', '湖北民族大学'),
  Team('普通学生队', '三峡大学'),
  Team('水之北', '湖南大学'),
  Team('WWW队', '中国人民解放军国防科技大学'),
  Team('山之南', '湖南大学'),
  Team('想要美食想要双休队', '火箭军工程大学'),
  Team('畅想车队一队', '成都锦城学院'),
  Team('畅想车队五队', '成都锦城学院'),
  Team('HotPot', '四川大学'),
  Team('天生', '西南大学'),
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
    team: groups.first.name,
    school_name: groups.first.schollName,
    sub_name: '',
    group: 0,
  );

  int curScore = 0;

  void changeOrg() async {
    Team? organization = await showMenu<Team>(
      context: context,
      position: RelativeRect.fromLTRB(10, 10, 10, 10),
      items: <PopupMenuEntry<Team>>[
        for (Team organization in groups)
          PopupMenuItem(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: organization.name,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '(${organization.schollName})',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            value: organization,
          ),
      ],
    );
    if (organization != null) {
      score.school_name = organization.schollName;
      score.team = organization.name;
      // score.school_name = organization.schollName;
    }
    print(score);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                              child: Text(score.team ?? ''),
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
                              child: RadioContainer<int>(
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
                              child: RadioContainer<int>(
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
                              child: RadioContainer<int>(
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
                              child: RadioContainer<int>(
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
                              child: RadioContainer<int>(
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureWithScale(
                  onTap: () async {
                    // print(await RestClient(Dio()).getScores());
                    if (gameIndex == 1) {
                      score.score1 = curScore;
                    } else {
                      score.score2 = curScore;
                    }
                    score.group = groupIndex;
                    score.time = DateTime.now().millisecond;
                    try {
                      Score res = await restClient.createScore(score);
                      showToast('录入成功');
                    } on DioError catch (e) {
                      showToast('录入失败');
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

typedef ChangeCall<T> = void Function(T value);

class RadioContainer<T> extends StatefulWidget {
  const RadioContainer({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.groupValue,
    required this.child,
    this.height,
  }) : super(key: key);

  final ChangeCall<T> onChanged;
  final T value;
  final T groupValue;
  final Widget child;
  final double? height;

  @override
  State createState() => _RadioContainerState<T>(onChanged);
}

class _RadioContainerState<T> extends State<RadioContainer>
    with SingleTickerProviderStateMixin {
  _RadioContainerState(this.onChanged);

  final ChangeCall<T> onChanged;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCheck = widget.value == widget.groupValue;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: isCheck
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2.w,
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                color: Colors.transparent,
                width: 2.w,
              ),
            ),
      padding: EdgeInsets.all(2.w),
      child: GestureWithScale(
        onTap: () {
          onChanged(widget.value as T);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffe8e9ee),
            borderRadius: BorderRadius.circular(6.w),
            // border: Border.all(
            //   color: Colors.grey.withOpacity(0.2),
            //   width: 2.w,
            // ),
          ),
          height: widget.height ?? 36.w,
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}

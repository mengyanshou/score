import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ShowScreen extends StatefulWidget {
  const ShowScreen({Key? key}) : super(key: key);

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  String ApiKey = 'http://nightmare.fun:8000/api/v1/score/';
  late Response response;
  List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    try {
      response = await Dio().get(ApiKey);
      data = response.data;

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Text(
                    'ENJOY AI Master 2022西部选拔赛',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '2022全国大学生智能汽车竞赛',
                    style: TextStyle(fontSize: 32.0),
                  ),
                  Text(
                    '百度智慧交通赛项',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('排名'),
                Text('学院|队伍'),
                Text('第一轮'),
                Text('第二轮'),
                Text('总分'),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${index + 1}'),
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/成都锦城学院.jpeg'),
                              radius: 16.0,
                            ),
                            Column(
                              children: [
                                Text(
                                  data[index]['sub_name'],
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(data[index]['school_name']),
                              ],
                            )
                          ],
                        ),
                        Text(
                          '${data[index]['score1']}',
                        ),
                        Text(
                          '${data[index]['score2']}',
                        ),
                        Text(
                            '${data[index]['score1'] + data[index]['score2']}'),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

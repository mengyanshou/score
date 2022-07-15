import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:score/gen.dart';

class ShowController extends GetxController {
  ShowController() {
    startPolling();
  }
  RestClient restClient = RestClient(Dio());
  List<Score> scores = [];
  late Timer timer;

  void startPolling() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      try {
        scores = await restClient.getScores();
        update();
      } catch (e) {
        print(e);
      }
    });
  }
}

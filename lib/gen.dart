import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'gen.g.dart';

@RestApi(baseUrl: "http://nightmare.fun:8000/api/v1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/score/")
  Future<Score> createScore(@Body() Score score);

  @GET("/score/")
  Future<List<Score>> getScores();
}

@JsonSerializable()
class Score {
  String? school_name;
  int? score1;
  int? score2;
  int? group;
  int? time;
  String? sub_name;
  String? team;

  Score({
    this.school_name,
    this.score1,
    this.score2,
    this.group,
    this.time,
    this.sub_name,
    this.team,
  });

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreToJson(this);
  @override
  String toString() {
    return 'school:${school_name} score1:$score1 score2:$score2 group:$group sub_name:$sub_name team:$team';
  }
}

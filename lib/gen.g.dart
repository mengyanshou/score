// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
      school_name: json['school_name'] as String?,
      score1: json['score1'] as int?,
      score2: json['score2'] as int?,
      group: json['group'] as int?,
      time: json['time'] as int?,
      sub_name: json['sub_name'] as String?,
    );

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
      'school_name': instance.school_name,
      'score1': instance.score1,
      'score2': instance.score2,
      'group': instance.group,
      'time': instance.time,
      'sub_name': instance.sub_name,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://nightmare.fun:8000/api/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Score> createScore(score) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(score.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Score>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/score/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Score.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Score>> getScores() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Score>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/score/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Score.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

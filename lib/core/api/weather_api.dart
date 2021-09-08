import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mms_app/app/constants.dart';
import 'package:mms_app/core/models/current_weather.dart';
import 'package:mms_app/core/utils/custom_exception.dart';
import 'package:mms_app/core/utils/error_util.dart';

import 'base_api.dart';

class WeatherApi extends BaseAPI {
  Logger log = Logger();

  Future<CurrentWeather> getCurrentData(String location) async {
    final String url = '/current?access_key=$accessKey&query=$location';

    try {
      final Response<dynamic> res = await dio.get<dynamic>(url);
      log.d(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          try {
            return CurrentWeather.fromJson(res.data);
          } catch (e) {
            throw PARSING_ERROR;
          }
          break;
        default:
          throw res.data['message'].first ?? 'Unknown Error';
      }
    } catch (e) {
      log.d(e);

      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<CurrentWeather> getHourlyData(String location) async {
    String startDate = DateTime.now().toString().substring(0, 10);
    String endDate =
        DateTime.now().add(Duration(days: 10)).toString().substring(0, 10);
    final String url =
        '/historical?access_key=$accessKey&query=$location&&historical_date_start=$startDate&historical_date_end=$endDate';
    try {
      final Response<dynamic> res = await dio.get<dynamic>(url);
      log.d(res.data);
      switch (res.statusCode) {
        case SERVER_OKAY:
          try {
            return CurrentWeather.fromJson(res.data);
          } catch (e) {
            throw PARSING_ERROR;
          }
          break;
        default:
          throw res.data['message'].first ?? 'Unknown Error';
      }
    } catch (e) {
      log.d(e);

      throw CustomException(DioErrorUtil.handleError(e));
    }
  }
}

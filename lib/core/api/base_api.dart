import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';

class BaseAPI {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: GlobalConfiguration().getString('base_url'),
      sendTimeout: 30000,
      receiveTimeout: 30000,
      contentType: 'application/json',
      validateStatus: (int s) => s < 500,
    ),
  );

  String accessKey = GlobalConfiguration().getString('access_key');
}

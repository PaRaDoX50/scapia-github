import 'package:dio/dio.dart';
import 'package:github_prs/utils/utils.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printDebug('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printDebug(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} ${response.data}',
    );
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    printDebug(
      'ERROR[${err.response?.toString()}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}

import 'package:dio/dio.dart';
import 'package:github_prs/data/api/log_interceptor.dart';

class ApiClient {
  final Dio _dio = Dio()..interceptors.add(Logging());

  Dio get dio => _dio;
  static const int perPage = 15;
  final String _baseUrl = 'https://api.github.com';
  String getPRsEndpoint(
      {required String repoUrl,
      required String creatorGithubHandle,
      required int page,
      required String state}) {
    return '$repoUrl/pulls?state=$state&creator=$creatorGithubHandle&page=$page&per_page=$perPage';
  }

  String getAllReposEndpoint(
      {required String userGithubHandle,
      required String type,
      required String sort,
      required String direction,
      required int page}) {
    return '$_baseUrl/users/$userGithubHandle/repos?type=$type&sort=$sort&direction=$direction&page=$page&per_page=$perPage';
  }
}

import 'package:github_prs/data/api/api_client.dart';
import 'package:github_prs/data/api/api_methods.dart';
import 'package:github_prs/data/models/pull_request.dart';
import 'package:github_prs/data/models/github_repository.dart';

class ApiMethodsImpl extends ApiMethods {
  final ApiClient apiClient;
  ApiMethodsImpl(this.apiClient);
  @override
  Future<List<GithubRepositoryEntity>> getAllGithubRepositories(
      {required String githubHandle,
      int page = 1,
      String type = 'all',
      String sort = 'updated',
      String direction = 'desc'}) async {
    final response = await apiClient.dio.get(
      apiClient.getAllReposEndpoint(
          userGithubHandle: githubHandle,
          type: type,
          sort: sort,
          direction: direction,
          page: page),
    );
    // print(response.data);
    final List<GithubRepositoryEntity> githubRepositories =
        (response.data as List)
            .map<GithubRepositoryEntity>(
                (repo) => GithubRepositoryEntity.fromJson(repo))
            .toList();
    return githubRepositories;
  }

  @override
  Future<List<PullRequestEntity>> getAllPullRequests(
      {required String repoUrl,
      required String creatorGithubHandle,
      int page = 1,
      String state = 'closed'}) async {
    final response = await apiClient.dio.get(apiClient.getPRsEndpoint(
        repoUrl: repoUrl,
        creatorGithubHandle: creatorGithubHandle,
        page: page,
        state: state));

    final List<PullRequestEntity> pullRequests =
        (response.data as List).map<PullRequestEntity>((pr) {
      return PullRequestEntity.fromJson(pr);
    }).toList();
    return pullRequests;
  }
}

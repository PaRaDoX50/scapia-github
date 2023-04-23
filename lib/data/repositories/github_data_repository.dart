import 'package:github_prs/data/api/api_methods.dart';
import 'package:github_prs/data/models/pull_request.dart';
import 'package:github_prs/data/models/github_repository.dart';
import 'package:github_prs/data/repositories/data_repository.dart';

class GithubDataRepository extends DataRepository {
  final ApiMethods apiMethods;
  GithubDataRepository(this.apiMethods);
  @override
  Future<List<GithubRepositoryModel>> getAllGithubRepositories(
      String githubHandle,
      {int page = 1,
      String type = 'all',
      String sort = 'updated',
      String direction = 'desc'}) async {
    final githubRepositories = await apiMethods.getAllGithubRepositories(
        githubHandle: githubHandle,
        page: page,
        type: type,
        sort: sort,
        direction: direction);
    return githubRepositories
        .map((e) => GithubRepositoryModel.fromEntity(e))
        .toList();
  }

  @override
  Future<List<PullRequest>> getAllPullRequests(
      String repoUrl, String creatorGithubHandle,
      {int page = 1, String state = 'closed'}) async {
    final pullRequests = await apiMethods.getAllPullRequests(
        repoUrl: repoUrl,
        creatorGithubHandle: creatorGithubHandle,
        page: page,
        state: state);
    return pullRequests.map((e) => PullRequest.fromEntity(e)).toList();
  }
}

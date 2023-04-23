import 'package:github_prs/data/models/github_repository.dart';
import 'package:github_prs/data/models/pull_request.dart';

abstract class ApiMethods {
  Future<List<GithubRepositoryEntity>> getAllGithubRepositories(
      {required String githubHandle,
      int page = 1,
      String type = 'all',
      String sort = 'updated',
      String direction = 'desc'});
  Future<List<PullRequestEntity>> getAllPullRequests(
      {required String repoUrl,
      required String creatorGithubHandle,
      int page = 1,
      String state = 'closed'});
}

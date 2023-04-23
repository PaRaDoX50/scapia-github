import 'package:github_prs/data/models/github_repository.dart';
import 'package:github_prs/data/models/pull_request.dart';

abstract class DataRepository {
  Future<List<GithubRepositoryModel>> getAllGithubRepositories(
      String githubHandle,
      {int page = 1,
      String type = 'all',
      String sort = 'updated',
      String direction = 'desc'});
  Future<List<PullRequest>> getAllPullRequests(
      String repoUrl, String creatorGithubHandle,
      {int page = 1, String state = 'closed'});
}

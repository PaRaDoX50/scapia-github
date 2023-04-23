class GithubRepoListScreenArguments {
  final String githubHandle;
  GithubRepoListScreenArguments({required this.githubHandle});
}

class PullRequestListScreenArguments {
  final String repoUrl;
  final String creatorGithubHandle;
  final String repoFullName;
  PullRequestListScreenArguments(
      {required this.repoUrl,
      required this.creatorGithubHandle,
      required this.repoFullName});
}

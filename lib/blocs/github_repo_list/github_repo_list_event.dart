part of 'github_repo_list_bloc.dart';

abstract class GithubRepoListEvent extends Equatable {
  const GithubRepoListEvent();
}

class GetGithubRepoListEvent extends GithubRepoListEvent {
  final String githubHandle;
  final bool forLoadMore;
  final int page;
  const GetGithubRepoListEvent(
      {required this.githubHandle,
      required this.page,
      required this.forLoadMore});
  @override
  List<Object> get props => [githubHandle, page, forLoadMore];
}

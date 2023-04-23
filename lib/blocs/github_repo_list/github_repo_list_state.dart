part of 'github_repo_list_bloc.dart';

abstract class GithubRepoListState extends Equatable {
  const GithubRepoListState();
}

class GithubRepoListInitial extends GithubRepoListState {
  @override
  List<Object?> get props => [];
}

class GithubRepoListSuccess extends GithubRepoListState {
  final List<GithubRepositoryModel> githubRepos;
  final bool hasReachedMax;
  const GithubRepoListSuccess(
      {required this.githubRepos, required this.hasReachedMax});
  @override
  List<Object?> get props => [githubRepos, hasReachedMax];
}

class InitialGithubRepoListLoading extends GithubRepoListState {
  @override
  List<Object?> get props => [];
}

class PaginatedGithubRepoListLoading extends GithubRepoListState {
  @override
  List<Object?> get props => [];
}

class GithubRepoListError extends GithubRepoListState {
  final String message;
  const GithubRepoListError(this.message);
  @override
  List<Object?> get props => [message];
}

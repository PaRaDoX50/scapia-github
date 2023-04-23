part of 'pull_request_list_bloc.dart';

@immutable
abstract class PullRequestListState extends Equatable {}

class PullRequestListInitial extends PullRequestListState {
  @override
  List<Object?> get props => [];
}

class PullRequestListSuccess extends PullRequestListState {
  final List<PullRequest> pullRequests;
  final bool hasReachedMax;
  PullRequestListSuccess(
      {required this.pullRequests, required this.hasReachedMax});
  @override
  List<Object?> get props => [pullRequests, hasReachedMax];
}

class InitialPullRequestListLoading extends PullRequestListState {
  @override
  List<Object?> get props => [];
}

class PaginatedPullRequestListLoading extends PullRequestListState {
  @override
  List<Object?> get props => [];
}

class PullRequestListError extends PullRequestListState {
  final String message;
  PullRequestListError(this.message);
  @override
  List<Object?> get props => [message];
}

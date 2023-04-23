part of 'pull_request_list_bloc.dart';

@immutable
abstract class PullRequestListEvent extends Equatable {}

class GetPullRequestListEvent extends PullRequestListEvent {
  final String creatorGithubHandle;
  final int page;
  final String repoUrl;
  final bool forLoadMore;

  GetPullRequestListEvent(
      {required this.creatorGithubHandle,
      required this.page,
      required this.repoUrl,
      required this.forLoadMore});
  @override
  List<Object> get props => [creatorGithubHandle, page, repoUrl, forLoadMore];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_prs/blocs/pull_request_list/pull_request_list_bloc.dart';
import 'package:github_prs/data/api/api_client.dart';
import 'package:github_prs/data/models/pull_request.dart';
import 'package:github_prs/data/repositories/github_data_repository.dart';
import 'package:github_prs/ui/common_widgets/circular_loading.dart';
import 'package:github_prs/ui/common_widgets/common_app_bar.dart';
import 'package:github_prs/ui/common_widgets/error_widget.dart';
import 'package:github_prs/ui/common_widgets/loading_more_tile.dart';
import 'package:github_prs/ui/screens/pull_requests_list/components/pr_tile.dart';
import 'package:github_prs/utils/utils.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class PullRequestListScreen extends StatefulWidget {
  const PullRequestListScreen(
      {super.key,
      required this.creatorHandle,
      required this.repoURL,
      required this.repoFullName});
  final String creatorHandle;
  final String repoURL;
  final String repoFullName;
  static const routeName = '/pull-request-list';

  @override
  State<PullRequestListScreen> createState() => _PullRequestListScreenState();
}

class _PullRequestListScreenState extends State<PullRequestListScreen> {
  late final PullRequestBloc _pullRequestBloc;

  @override
  void initState() {
    super.initState();

    _pullRequestBloc = PullRequestBloc(
        dataRepository: RepositoryProvider.of<GithubDataRepository>(context));
    _pullRequestBloc.add(GetPullRequestListEvent(
        creatorGithubHandle: widget.creatorHandle,
        page: 1,
        repoUrl: widget.repoURL,
        forLoadMore: false));
  }

  List<PullRequest> _pullRequests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Closed Pull Requests',
        elevation: 1,
      ),
      body: LazyLoadScrollView(
        onEndOfPage: _loadMorePRs,
        child: CustomScrollView(
          slivers: [
            BlocConsumer<PullRequestBloc, PullRequestListState>(
                bloc: _pullRequestBloc,
                listener: (context, state) {
                  setState(() {});
                },
                builder: (context, state) {
                  if (state is InitialPullRequestListLoading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularLoading(),
                      ),
                    );
                  }
                  if (state is PullRequestListSuccess ||
                      state is PaginatedPullRequestListLoading) {
                    if (state is PullRequestListSuccess) {
                      _pullRequests = state.pullRequests;
                    }
                    return _pullRequests.isEmpty
                        ? const SliverFillRemaining(
                            child: Center(
                              child: Text('No closed PRs found'),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext _, int index) {
                                final pr = _pullRequests[index];
                                var tile = PRTile(
                                    pr: pr, repoFullName: widget.repoFullName);
                                if (state is PaginatedPullRequestListLoading &&
                                    index == _pullRequests.length - 1) {
                                  return LoadingMoreTile(tile: tile);
                                }
                                return tile;
                              },
                              childCount: _pullRequests.length,
                            ),
                          );
                  }
                  if (state is PullRequestListError) {
                    return SliverFillRemaining(
                      child: Center(child: ErrorScreen(
                        onRefresh: () {
                          _pullRequestBloc.add(GetPullRequestListEvent(
                              creatorGithubHandle: widget.creatorHandle,
                              page: 1,
                              repoUrl: widget.repoURL,
                              forLoadMore: false));
                        },
                      )),
                    );
                  }
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularLoading(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  void _loadMorePRs() {
    PullRequestListState currentState = _pullRequestBloc.state;
    printDebug(_pullRequests.length.toString() + 'zz');
    if (currentState is PullRequestListSuccess) {
      printDebug(_pullRequests.length.toString() + 'zz');
      _pullRequestBloc.add(GetPullRequestListEvent(
          forLoadMore: true,
          creatorGithubHandle: widget.creatorHandle,
          page: (_pullRequests.length / ApiClient.perPage).toInt() + 1,
          repoUrl: widget.repoURL));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pullRequestBloc.close();
  }
}

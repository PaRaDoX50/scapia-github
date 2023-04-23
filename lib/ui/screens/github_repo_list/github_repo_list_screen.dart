import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_prs/blocs/github_repo_list/github_repo_list_bloc.dart';
import 'package:github_prs/data/api/api_client.dart';
import 'package:github_prs/data/api/api_methods_impl.dart';
import 'package:github_prs/data/models/github_repository.dart';
import 'package:github_prs/data/repositories/github_data_repository.dart';
import 'package:github_prs/ui/common_widgets/circular_loading.dart';
import 'package:github_prs/ui/common_widgets/common_app_bar.dart';
import 'package:github_prs/ui/common_widgets/error_widget.dart';
import 'package:github_prs/ui/common_widgets/loading_more_tile.dart';
import 'package:github_prs/ui/screens/github_repo_list/components/github_repo_tile.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class GithubRepoListScreen extends StatefulWidget {
  final String githubHandle;
  static const routeName = '/github-repo-list';
  const GithubRepoListScreen({super.key, required this.githubHandle});

  @override
  State<GithubRepoListScreen> createState() => _GithubRepoListScreenState();
}

class _GithubRepoListScreenState extends State<GithubRepoListScreen> {
  late final GithubRepoListBloc _githubRepoListBloc;
  late final GithubDataRepository _githubDataRepository;
  List<GithubRepositoryModel> _githubRepos = [];
  @override
  void initState() {
    super.initState();
    _githubDataRepository = GithubDataRepository(ApiMethodsImpl(ApiClient()));
    _githubRepoListBloc =
        GithubRepoListBloc(dataRepository: _githubDataRepository);
    _githubRepoListBloc.add(GetGithubRepoListEvent(
        forLoadMore: false, githubHandle: widget.githubHandle, page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: '${widget.githubHandle}\'s Repositories'),
      body: LazyLoadScrollView(
        onEndOfPage: _loadMoreStores,
        child: CustomScrollView(
          slivers: [
            BlocConsumer<GithubRepoListBloc, GithubRepoListState>(
                bloc: _githubRepoListBloc,
                listener: (context, state) {
                  setState(() {});
                },
                builder: (context, state) {
                  if (state is InitialGithubRepoListLoading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularLoading(),
                      ),
                    );
                  }
                  if (state is GithubRepoListSuccess ||
                      state is PaginatedGithubRepoListLoading) {
                    if (state is GithubRepoListSuccess) {
                      _githubRepos = state.githubRepos;
                    }
                    return _githubRepos.isEmpty
                        ? const SliverFillRemaining(
                            child: Center(
                              child: Text('No repos found'),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                            (BuildContext _, int index) {
                              final repo = _githubRepos[index];
                              var tile = GithubRepoTile(
                                  githubHandle: widget.githubHandle,
                                  repo: repo);
                              if (state is PaginatedGithubRepoListLoading &&
                                  index == _githubRepos.length - 1) {
                                return LoadingMoreTile(tile: tile);
                              }
                              return tile;
                            },
                            childCount: _githubRepos.length,
                          ));
                  }
                  if (state is GithubRepoListError) {
                    return SliverFillRemaining(
                      child: Center(child: ErrorScreen(
                        onRefresh: () {
                          _githubRepoListBloc.add(GetGithubRepoListEvent(
                              githubHandle: widget.githubHandle,
                              page: 1,
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

  void _loadMoreStores() {
    GithubRepoListState currentState = _githubRepoListBloc.state;
    if (!_githubRepoListBloc.hasReachedMax(currentState, true)) {
      if (currentState is GithubRepoListSuccess) {
        _githubRepoListBloc.add(GetGithubRepoListEvent(
            githubHandle: widget.githubHandle,
            page: (_githubRepos.length / ApiClient.perPage).toInt() + 1,
            forLoadMore: true));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _githubRepoListBloc.close();
  }
}

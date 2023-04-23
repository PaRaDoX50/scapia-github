import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_prs/data/api/api_client.dart';
import 'package:github_prs/data/models/github_repository.dart';
import 'package:github_prs/data/repositories/data_repository.dart';

part 'github_repo_list_event.dart';
part 'github_repo_list_state.dart';

class GithubRepoListBloc
    extends Bloc<GithubRepoListEvent, GithubRepoListState> {
  final DataRepository dataRepository;
  GithubRepoListBloc({required this.dataRepository})
      : super(GithubRepoListInitial()) {
    on<GithubRepoListEvent>((event, emit) async {
      if (event is GetGithubRepoListEvent) {
        await _mapGetGithubRepoListToState(
            githubHandle: event.githubHandle,
            page: event.page,
            forLoadMore: event.forLoadMore,
            emit: emit);
      }
    });
  }

  bool hasReachedMax(GithubRepoListState state, bool forLoadMore) =>
      state is GithubRepoListSuccess && state.hasReachedMax && forLoadMore;

  FutureOr<void> _mapGetGithubRepoListToState(
      {required String githubHandle,
      required int page,
      required bool forLoadMore,
      required Emitter<GithubRepoListState> emit}) async {
    if (!hasReachedMax(state, forLoadMore)) {
      try {
        List<GithubRepositoryModel> githubRepos = [];
        if (state is GithubRepoListSuccess) {
          githubRepos = (state as GithubRepoListSuccess).githubRepos;
          emit(PaginatedGithubRepoListLoading());
        } else {
          emit(InitialGithubRepoListLoading());
        }

        List<GithubRepositoryModel> moreRepos =
            await dataRepository.getAllGithubRepositories(
          githubHandle,
          page: page,
        );
        emit(GithubRepoListSuccess(
            githubRepos: githubRepos + moreRepos,
            hasReachedMax:
                moreRepos.isEmpty || moreRepos.length < ApiClient.perPage));
      } on Exception catch (e) {
        emit(GithubRepoListError(e.toString()));
      }
    }
  }
}

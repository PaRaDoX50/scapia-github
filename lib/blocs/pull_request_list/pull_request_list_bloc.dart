import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_prs/data/api/api_client.dart';
import 'package:github_prs/data/models/pull_request.dart';
import 'package:github_prs/data/repositories/data_repository.dart';

part 'pull_request_list_event.dart';
part 'pull_request_list_state.dart';

class PullRequestBloc extends Bloc<PullRequestListEvent, PullRequestListState> {
  final DataRepository dataRepository;
  PullRequestBloc({required this.dataRepository})
      : super(PullRequestListInitial()) {
    on<PullRequestListEvent>((event, emit) async {
      if (event is GetPullRequestListEvent) {
        await _mapGetPullRequestListToState(
            creatorGithubHandle: event.creatorGithubHandle,
            page: event.page,
            repoUrl: event.repoUrl,
            forLoadMore: event.forLoadMore,
            emit: emit);
      }
    });
  }
  bool hasReachedMax(PullRequestListState state, bool forLoadMore) =>
      state is PullRequestListSuccess && state.hasReachedMax && forLoadMore;
  FutureOr<void> _mapGetPullRequestListToState(
      {required String creatorGithubHandle,
      required int page,
      required String repoUrl,
      required bool forLoadMore,
      required Emitter<PullRequestListState> emit}) async {
    if (!hasReachedMax(state, forLoadMore)) {
      try {
        List<PullRequest> prs = [];
        if (state is PullRequestListSuccess) {
          prs = (state as PullRequestListSuccess).pullRequests;
          emit(PaginatedPullRequestListLoading());
        } else {
          emit(InitialPullRequestListLoading());
        }

        List<PullRequest> morePRs = await dataRepository
            .getAllPullRequests(repoUrl, creatorGithubHandle, page: page);
        emit(PullRequestListSuccess(
            pullRequests: prs + morePRs,
            hasReachedMax:
                morePRs.isEmpty || morePRs.length < ApiClient.perPage));
      } on Exception catch (e) {
        emit(PullRequestListError(e.toString()));
      }
    }
  }
}

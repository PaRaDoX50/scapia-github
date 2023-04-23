import 'package:github_prs/data/models/github_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pull_request.g.dart';

class PullRequest {
  final int id;
  final String title;
  final String? body;
  final String state;
  final String url;
  final String htmlUrl;
  final GithubRepositoryModel? repo;
  final DateTime createdAt;
  // final Owner user;

  PullRequest({
    required this.id,
    required this.title,
    required this.body,
    required this.state,
    required this.url,
    required this.htmlUrl,
    required this.repo,
    required this.createdAt,
    // required this.user,
  });

  factory PullRequest.fromEntity(PullRequestEntity entity) {
    return PullRequest(
      repo: entity.head.repo != null
          ? GithubRepositoryModel.fromEntity(entity.head.repo!)
          : null,
      id: entity.id,
      title: entity.title,
      body: entity.body,
      state: entity.state,
      url: entity.url,
      htmlUrl: entity.htmlUrl,
      createdAt: DateTime.tryParse(entity.createdAt) ?? DateTime.now(),
      // user: Owner.fromEntity(entity.user),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PullRequestEntity {
  final int id;
  final String title;
  final String? body;
  final String state;
  final String url;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final Head head;
  @JsonKey(name: 'created_at')
  final String createdAt;
  // final OwnerEntity user;

  PullRequestEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.state,
    required this.url,
    required this.htmlUrl,
    required this.head,
    required this.createdAt,
    // required this.user,
  });

  factory PullRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$PullRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PullRequestEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Head {
  final GithubRepositoryEntity? repo;

  Head({required this.repo});

  factory Head.fromJson(Map<String, dynamic> json) => _$HeadFromJson(json);

  Map<String, dynamic> toJson() => _$HeadToJson(this);
}

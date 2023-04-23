// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PullRequestEntity _$PullRequestEntityFromJson(Map<String, dynamic> json) =>
    PullRequestEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String?,
      state: json['state'] as String,
      url: json['url'] as String,
      htmlUrl: json['html_url'] as String,
      head: Head.fromJson(json['head'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$PullRequestEntityToJson(PullRequestEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'state': instance.state,
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'head': instance.head.toJson(),
      'created_at': instance.createdAt,
    };

Head _$HeadFromJson(Map<String, dynamic> json) => Head(
      repo: json['repo'] == null
          ? null
          : GithubRepositoryEntity.fromJson(
              json['repo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HeadToJson(Head instance) => <String, dynamic>{
      'repo': instance.repo?.toJson(),
    };

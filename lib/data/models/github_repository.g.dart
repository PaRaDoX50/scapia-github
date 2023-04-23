// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubRepositoryEntity _$GithubRepositoryEntityFromJson(
        Map<String, dynamic> json) =>
    GithubRepositoryEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String?,
      private: json['private'] as bool,
      url: json['url'] as String,
      owner: OwnerEntity.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GithubRepositoryEntityToJson(
        GithubRepositoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'description': instance.description,
      'private': instance.private,
      'url': instance.url,
      'owner': instance.owner.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerEntity _$OwnerEntityFromJson(Map<String, dynamic> json) => OwnerEntity(
      id: json['id'] as int,
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      url: json['url'] as String,
      htmlUrl: json['html_url'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$OwnerEntityToJson(OwnerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'type': instance.type,
    };

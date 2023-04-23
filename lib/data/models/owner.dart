import 'package:json_annotation/json_annotation.dart';
part 'owner.g.dart';

class Owner {
  final int id;
  final String login;
  final String avatarUrl;
  final String url;
  final String htmlUrl;
  final String type;
  Owner({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
    required this.type,
  });

  factory Owner.fromEntity(OwnerEntity entity) {
    return Owner(
      id: entity.id,
      login: entity.login,
      avatarUrl: entity.avatarUrl,
      url: entity.url,
      htmlUrl: entity.htmlUrl,
      type: entity.type,
    );
  }
}

@JsonSerializable()
class OwnerEntity {
  final int id;
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  final String url;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String type;

  OwnerEntity({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
    required this.type,
  });

  factory OwnerEntity.fromJson(Map<String, dynamic> json) =>
      _$OwnerEntityFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerEntityToJson(this);
}

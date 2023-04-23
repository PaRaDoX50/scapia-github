import 'package:github_prs/data/models/owner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_repository.g.dart';

class GithubRepositoryModel {
  final int id;
  final String name;
  final String fullName;
  final String? description;
  final bool private;
  final String url;
  final Owner owner;

  GithubRepositoryModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.private,
    required this.url,
    required this.owner,
  });

  factory GithubRepositoryModel.fromEntity(GithubRepositoryEntity entity) {
    return GithubRepositoryModel(
      id: entity.id,
      name: entity.name,
      fullName: entity.fullName,
      description: entity.description,
      private: entity.private,
      url: entity.url,
      owner: Owner.fromEntity(entity.owner),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GithubRepositoryEntity {
  final int id;
  final String name;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String? description;
  final bool private;
  final String url;
  final OwnerEntity owner;

  GithubRepositoryEntity({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.private,
    required this.url,
    required this.owner,
  });

  factory GithubRepositoryEntity.fromJson(Map<String, dynamic> json) =>
      _$GithubRepositoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GithubRepositoryEntityToJson(this);
}

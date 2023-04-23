import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_prs/data/models/github_repository.dart';
import 'package:github_prs/data/navigation/arguments.dart';
import 'package:github_prs/ui/screens/pull_requests_list/pull_request_list.dart';

class GithubRepoTile extends StatelessWidget {
  final String githubHandle;
  final GithubRepositoryModel repo;
  const GithubRepoTile(
      {super.key, required this.githubHandle, required this.repo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, PullRequestListScreen.routeName,
            arguments: PullRequestListScreenArguments(
                creatorGithubHandle: githubHandle,
                repoUrl: repo.url,
                repoFullName: repo.fullName));
      },
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: CachedNetworkImageProvider(repo.owner.avatarUrl))),
      ),
      title: Text(
        repo.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        repo.fullName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

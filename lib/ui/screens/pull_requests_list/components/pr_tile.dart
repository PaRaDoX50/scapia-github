import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_prs/data/models/pull_request.dart';
import 'package:github_prs/ui/theme_constants.dart';
import 'package:github_prs/utils/utils.dart';

class PRTile extends StatelessWidget {
  final PullRequest pr;
  final String repoFullName;
  const PRTile({super.key, required this.pr, required this.repoFullName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/merge.svg',
                color: Colors.deepPurple,
                width: 30,
                height: 30,
              ),
              khorizontalMargin16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pr.repo != null ? pr.repo!.fullName : repoFullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ktextStyle16),
                    kverticalMargin4,
                    Text(
                      pr.title,
                      style: ktextStyle16W500.copyWith(color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              khorizontalMargin4,
              Text(daysFromDatetimeToNow(pr.createdAt),
                  style: ktextStyle16.copyWith(color: Colors.grey)),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
        )
      ],
    );
  }
}

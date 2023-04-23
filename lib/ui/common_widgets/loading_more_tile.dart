import 'package:flutter/material.dart';
import 'package:github_prs/ui/common_widgets/circular_loading.dart';
import 'package:github_prs/ui/theme_constants.dart';

class LoadingMoreTile extends StatelessWidget {
  final Widget tile;
  const LoadingMoreTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return tile;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: tile,
        ),
        kverticalMargin16,
        const SizedBox(
          height: 30,
          width: 30,
          child: CircularLoading(),
        ),
        kverticalMargin16,
      ],
    );
  }
}

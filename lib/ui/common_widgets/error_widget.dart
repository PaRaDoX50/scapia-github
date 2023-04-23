import 'package:flutter/material.dart';
import 'package:github_prs/ui/theme_constants.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onRefresh;
  final String? message;

  const ErrorScreen({super.key, required this.onRefresh, this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset('assets/images/no_results.png'),
          kverticalMargin16,
          Text(
            message ?? 'Something went wrong',
            style: ktextStyle16Bold.copyWith(color: Colors.grey),
          ),
          kverticalMargin16,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 16)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: onRefresh,
                child: const Text(
                  'Retry',
                  style: ktextStyle16,
                )),
          )
        ],
      ),
    );
  }
}

enum ErrorCTA { home, reload }

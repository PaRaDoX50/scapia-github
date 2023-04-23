import 'package:flutter/material.dart';
import 'package:github_prs/data/navigation/arguments.dart';
import 'package:github_prs/ui/screens/github_repo_list/github_repo_list_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_prs/ui/theme_constants.dart';

class GithubHandleFormScreen extends StatelessWidget {
  GithubHandleFormScreen({super.key});
  final TextEditingController _githubHandleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.95),
      // appBar: CommonAppBar(
      //   title: '',
      //   elevation: 0,
      //   flexibleSpace: SafeArea(
      //     child: Center(child: SvgPicture.asset('assets/github-logo.svg')),
      //   ),
      // ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Expanded(
                  child: SvgPicture.asset('assets/github-logo.svg',
                      width: double.infinity)),
              kverticalMargin16,
              const Text(
                'Enter your Github handle',
                style: ktextStyle20,
              ),
              kverticalMargin16,
              TextField(
                controller: _githubHandleController,
                maxLines: 1,
                style: ktextStyle20,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              kverticalMargin16,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 16)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, GithubRepoListScreen.routeName,
                          arguments: GithubRepoListScreenArguments(
                              githubHandle: _githubHandleController.text));
                    },
                    child: const Text(
                      'Submit',
                      style: ktextStyle16,
                    )),
              ),
              kverticalMargin16,
            ]),
          ),
        ),
      ),
    );
  }
}

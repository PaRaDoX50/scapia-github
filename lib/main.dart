import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_prs/data/api/api_client.dart';
import 'package:github_prs/data/api/api_methods_impl.dart';
import 'package:github_prs/data/navigation/arguments.dart';
import 'package:github_prs/data/repositories/github_data_repository.dart';
import 'package:github_prs/simple_bloc_observer.dart';
import 'package:github_prs/ui/screens/github_handle_form/github_handle_form.dart';
import 'package:github_prs/ui/screens/github_repo_list/github_repo_list_screen.dart';
import 'package:github_prs/ui/screens/pull_requests_list/pull_request_list.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GithubDataRepository _githubDataRepository;

  late final ApiMethodsImpl _apiMethodsImpl;
  late final ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _apiClient = ApiClient();
    _apiMethodsImpl = ApiMethodsImpl(_apiClient);
    _githubDataRepository = GithubDataRepository(_apiMethodsImpl);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<GithubDataRepository>(
      create: (context) => _githubDataRepository,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GithubHandleFormScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case GithubRepoListScreen.routeName:
              final arg = settings.arguments as GithubRepoListScreenArguments;
              return MaterialPageRoute(
                builder: (context) =>
                    GithubRepoListScreen(githubHandle: arg.githubHandle),
              );
            case PullRequestListScreen.routeName:
              final arg = settings.arguments as PullRequestListScreenArguments;
              return MaterialPageRoute(
                builder: (context) => PullRequestListScreen(
                  creatorHandle: arg.creatorGithubHandle,
                  repoURL: arg.repoUrl,
                  repoFullName: arg.repoFullName,
                ),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => GithubHandleFormScreen(),
              );
          }
        },
      ),
    );
  }
}

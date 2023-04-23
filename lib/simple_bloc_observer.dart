import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_prs/utils/utils.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    printDebug("$event BLOC");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    printDebug("$transition BLOC");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) async {
    printDebug("$error BLOC" + bloc.toString());
    super.onError(bloc, error, stackTrace);
  }
}

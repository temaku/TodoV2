import 'package:bloc/bloc.dart';

class SimpleBLocObserver extends BlocObserver{
    @override
  void onEvent(Bloc bloc, Object event) {
      print("onEvent $event");
    super.onEvent(bloc, event);
  }
  @override
  void onTransition(Bloc bloc, Transition transition) {
      print('onTranstion $transition');
    super.onTransition(bloc, transition);
  }
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
      print('onError $error');
    super.onError(cubit, error, stackTrace);
  }
}
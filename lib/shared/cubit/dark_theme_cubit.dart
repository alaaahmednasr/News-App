import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/dark_theme_state.dart';
import '../network/local/cache_helper.dart';

class NewsDarkCubit extends Cubit<NewsDarkStates> {
  NewsDarkCubit() : super(InitialDarkState());

  static NewsDarkCubit getCubit(context) => BlocProvider.of(context);
 
 bool isDark = false;

  void changeAppMode({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark)
          .then((value) => emit(ChangeModeState()));
    }
  }
}
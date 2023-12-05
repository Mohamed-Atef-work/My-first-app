import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/shared/cubit/states.dart';
import '../../modules/to_do_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/to_do_app/done_tasks/done_tasks_screen.dart';
import '../../modules/to_do_app/new_tasks/new_tasks_screen.dart';
import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];

  void changIndex(int index) {
    currentIndex = index;
    emit(AppChangedBottomNavBarState());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangedModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: "isDark", value: isDark)
          .then((value) => emit(AppChangedModeState()));
    }
  }
}

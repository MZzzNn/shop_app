import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import '../components/constants.dart';
import '../network/local/cache_helper.dart';
import '../styles/colors.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeAppMode({bool fromShared}) {
    isDarkC = this.isDark;
    if (fromShared != null) {
      isDark = fromShared;
      isDarkC = this.isDark;
    } else {
      isDark = !isDark;
      isDarkC = this.isDark;
    }
    if (isDark) {
      defaultColor = Color(0xff00ADB5);
    } else {
      defaultColor = Colors.indigo;
    }
    CacheHelper.saveData(key: "isDark", value: isDark).then((value) {
      emit(AppChangeModeState());
    });
  }
}

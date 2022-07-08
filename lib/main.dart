import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  isDarkC = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  Widget widget;
  if (onBoarding != null) {
    if (token != null) widget = ShopLayout();
    else widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
        () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
  runApp(MyApp(
    isDark: isDarkC,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp({Key key, this.isDark, this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>AppCubit()..changeAppMode(fromShared: isDark),),
        BlocProvider(create: (BuildContext context)=>
        ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData(),),
      ],
      child:BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context,state){},
        builder: (BuildContext context, state) {
          var cubit =AppCubit.get(context);
          return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:cubit.isDark? ThemeMode.dark : ThemeMode.light,
              home: startWidget,
            );
        },
      )
    );
  }
}

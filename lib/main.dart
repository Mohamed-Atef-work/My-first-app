import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/news_app/cubit/cubit.dart';
import 'package:my_first_app/layout/news_app/news_layout.dart';
import 'package:my_first_app/layout/shop_layout/cubit/cubit.dart';
import 'package:my_first_app/layout/shop_layout/shop_layout.dart';
import 'package:my_first_app/modules/shop_app/login/login_screen.dart';
import 'package:my_first_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';
import 'package:my_first_app/social_app/Cubit/Cubit.dart';
import 'package:my_first_app/social_app/layout/social_layout.dart';
import 'package:my_first_app/social_app/modules/login/login_screen.dart';
import 'package:my_first_app/styles/themes.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'social_app/modules/chats_details/cubit/cubit.dart';

// ErrorWidget.builder = (FlutterErrorDetails details) {
//   return Material(
//     child: Container(
//       color: Colors.green,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             details.exception.toString(),
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// };

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  //WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  //bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  //token = CacheHelper.getData(key: "token");

  /* if (onBoarding != null) {
    if (token != null)
      startWidget = ShopLayout();
    else
      startWidget = ShopLoginScreen();
  } else {
    startWidget = OnBoardingScreen();
  }*/

  //print("is shopLayout ${startWidget is ShopLayout}");

  CacheHelper.saveData(key: "isDark", value: false);

  bool? isDark = CacheHelper.getData(key: "isDark");

  uId = CacheHelper.getData(key: "uId");
  print(uId);

  Widget startWidget;

  if (uId != null) {
    startWidget = SocialLayout();
  } else {
    startWidget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: startWidget,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  //String value = NewsCubit.value;

  late final bool? isDark;
  Widget startWidget;

  MyApp({this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..getSports()),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: isDark),
        ),
        /*BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getUserData()
              ..getCategories()
              ..getHomeData()
              ..getFavorites()),*/
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getPosts()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: DarkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: SocialLoginScreen(),
          );
        },
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

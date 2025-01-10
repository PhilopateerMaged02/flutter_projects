import 'package:flutter/foundation.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/layout/shop_app/cubit/cubit.dart';
import 'package:news_app/layout/shop_app/shop_layout.dart';
import 'package:news_app/modules/ShopApp/onboarding/onboarding_screen.dart';
import 'package:news_app/modules/ShopApp/shop_login/login_screen.dart';
//import 'package:news_app/modules/onboarding/onboarding_screen.dart';
//import 'package:news_app/modules/shop_login/login_screen.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/styles/themes.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  print(onBoarding);
  Widget widget;
  token = CacheHelper.getData(key: 'token');
  if(onBoarding != null)
  {
    if(token != null)
    {
      widget = ShopScreen();
    }
    else
    {
      widget =  LoginScreen();
    }
  }
  else
  {
    widget = onBoardingScreen();
  }
 runApp(MyApp(isDark,widget));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp(this.isDark,this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsAppCubit()..getBuisnessData()..getSportsData()..getScienceData(),),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark),),
        BlocProvider(create: (BuildContext context) => ShopAppCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getProfile()),
      ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: NewsHomeScreen(),
              themeMode: ThemeMode.light,
            );
          },
        ),
      );
  }
}

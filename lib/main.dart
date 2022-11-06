import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_secreen.dart';
import 'package:shop_app/modules/shop_app/onboarding/onboarding_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'shared/bloc_observer.dart';

// import 'package:conditional_builder/conditional_builder.dart';

//@dart=2.9
void main() async{
  //بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يفتح الابليكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget? widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  String? token = CacheHelper.getData(key: 'token');

  var uId = CacheHelper.getData(key: 'uId');

//  print(token);

  if(onBoarding != null)
    {
      if(token != null)
        {
          widget = ShopLayout();
        }
      else
        {
          widget = ShopLoginScreen();
        }
    }
  else
    {
      widget = OnBoardingScreen();
    }


  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget? startWidget;
  MyApp({
    this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
          // fromShared: isDark!,
        ),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)
        {
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,

            home: startWidget,
          );
        },
      ),
    );
  }
}
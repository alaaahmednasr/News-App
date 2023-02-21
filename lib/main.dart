// ignore_for_file: deprecated_member_use, unused_local_variable, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/dark_theme_cubit.dart';
import 'package:news_app/shared/cubit/dark_theme_state.dart';
import 'package:news_app/shared/cubit/observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark')??false;

  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {

  bool? isDark ;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsDarkCubit()..changeAppMode(fromShared: isDark!),),
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusinessData(),),
      ],
      child: BlocConsumer<NewsDarkCubit, NewsDarkStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = NewsDarkCubit.getCubit(context);
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
            titleSpacing: 20,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.teal,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.teal,
              size: 30,
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.teal,
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
            titleSpacing: 20,
            backgroundColor: Colors.black,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.teal,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.teal,
              size: 30,
            ),
             backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          scaffoldBackgroundColor: Colors.black,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black12,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        themeMode:  NewsDarkCubit.getCubit(context).isDark ? ThemeMode.dark : ThemeMode.light,
        home: const NewsLayout(),
           );
        },
      ),
    );
  }
}

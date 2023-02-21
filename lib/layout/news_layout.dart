import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import '../shared/cubit/dark_theme_cubit.dart';
import '../shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = NewsCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  SearchScreen(),),);
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed: ()
                  {
                    NewsDarkCubit.getCubit(context).changeAppMode();
                  },
                ),
                const SizedBox(width: 10,),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: getCubit.currentIndex,
              onTap: (index) {
                getCubit.bottomNavigationBarTap(index);
              },
              items: getCubit.bottomNavigationBarItem,
            ),
            body: getCubit.screens[getCubit.currentIndex],
          );
        },
      ); 
  }
}

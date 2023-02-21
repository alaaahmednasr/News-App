// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen/business_screen.dart';
import 'package:news_app/modules/science_screen/science_screen.dart';
import 'package:news_app/modules/sports_screen/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit getCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
  ];

  void bottomNavigationBarTap(int index) {
    currentIndex = index;
    if (index == 1) {
      getScience();
    }
    if (index == 2) {
      getSportsData();
    }
    emit(BottomNavigationBarTapState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      methodUrl: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'cfa82bc5bd434c21ad70e64b1a242fc4',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState());
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(
      methodUrl: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'cfa82bc5bd434c21ad70e64b1a242fc4',
      },
    ).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState());
    });
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(
      methodUrl: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'cfa82bc5bd434c21ad70e64b1a242fc4',
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState());
    });
  }

List<dynamic> search = [];

  void getSearchData(String value) {
    emit(NewsSearchLoadingState());
    DioHelper.getData(
      methodUrl: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'cfa82bc5bd434c21ad70e64b1a242fc4',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });
  }


}
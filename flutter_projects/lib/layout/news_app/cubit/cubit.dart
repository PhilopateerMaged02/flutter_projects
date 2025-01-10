import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/NewsApp/news_business/buisness_screen.dart';
import 'package:news_app/modules/NewsApp/news_science/science_screen.dart';
import 'package:news_app/modules/NewsApp/news_sports/sport_screen.dart';
//import 'package:news_app/modules/news_business/buisness_screen.dart';
//import 'package:news_app/modules/news_science/science_screen.dart';
//import 'package:news_app/modules/news_sports/sport_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(NewsAppInitialState());
  static NewsAppCubit get(context) => BlocProvider.of(context);

  int currindex = 0;
  ThemeData lightTheme = ThemeData.light();
  ThemeData darkTheme = ThemeData.dark();

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(label: 'Business', icon: Icon(Icons.business_sharp)),
    BottomNavigationBarItem(label: 'Sports', icon: Icon(Icons.sports_basketball)),
    BottomNavigationBarItem(label: 'Science', icon: Icon(Icons.science)),
  ];

  List<Widget> screens = [
    BuisnessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  void changeIndex(int index) {
    currindex = index;
    emit(NewsAppNavBarState());
  }


  List<dynamic> buisness = [];
  void getBuisnessData()
  {
    emit(NewsGetBuisnessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'us',
          'category':'business',
          'apiKey':'4fe57bd736e04350b3c0cc698263fab3',
        }).then((value)
    {
      //print(value.data['articles'][0]['title']);
      buisness = value.data['articles'];
      //print(buisness[0]['title']);
      emit(NewsGetBuisnessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBuisnessErrorState());
    });
  }

  List<dynamic> sports = [];
  void getSportsData()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'us',
            'category':'sport',
            'apiKey':'4fe57bd736e04350b3c0cc698263fab3',
          }).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        //print(buisness[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSportsErrorState());
      });
    }
    emit(NewsGetSportsSuccessState());
  }

  List<dynamic> science = [];
  void getScienceData()
  {
    if(science.length == 0)
    {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'us',
            'category':'science',
            'apiKey':'4fe57bd736e04350b3c0cc698263fab3',
          }).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        //print(buisness[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetScienceErrorState());
      });
    }
    else
    {
      emit(NewsGetScienceSuccessState());
    }
  }


  List<dynamic> search = [];
  void getSearchData(String value)
  {
      emit(NewsGetSearchLoadingState());
      search = [];

      DioHelper.getData(
          url: 'v2/everything',
          query:
          {
            'q':'$value',
            'apiKey':'4fe57bd736e04350b3c0cc698263fab3',
          }).then((value)
      {
        //print(value.data['articles'][0]['title']);
        search = value.data['articles'];
        //print(buisness[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSearchErrorState());
      });
  }

}

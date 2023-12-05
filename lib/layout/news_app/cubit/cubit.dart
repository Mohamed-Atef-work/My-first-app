import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/news_app/cubit/states.dart';
import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
    //BottomNavigationBarItem(
    // icon: Icon(Icons.settings),
    // label: "Settings",
    //),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    //SettingsScreen()
  ];

  void changeBottomAppBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country": "eg",
        "category": "business",
        "apiKey": "40e8e5accae049fda753f567995efc4a",
      },
    ).then((value) {
      emit(NewsGetBusinessSuccessState());
      //print(value.data);
      business = value.data['articles'];
      print(business[0]);
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }

  List sports = [];

  void getSports() {
    emit(NewsGetSportLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "sports",
          "apiKey": "40e8e5accae049fda753f567995efc4a",
        },
      ).then((value) {
        emit(NewsGetSportSuccessState());
        //print(value.data);
        sports = value.data['articles'];
        print(sports[0]);
      }).catchError((error) {
        emit(NewsGetSportErrorState(error.toString()));
        print("The error is ------------------->${error.toString()}");
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  List science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "language": "en",
          "country": "us",
          //"category": "science",
          //"sources":"techcrunch",
          "apiKey": "40e8e5accae049fda753f567995efc4a",
        },
      ).then((value) {
        emit(NewsGetScienceSuccessState());
        //print(value.data);
        science = value.data['articles'];
        print(science[0]);
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        print("The error is ------------------->${error.toString()}");
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  //static late String value;
  List search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: "v2/everything",
      query: {
        "q": "$value",
        "apiKey": "40e8e5accae049fda753f567995efc4a",
      },
    ).then((value) {
      emit(NewsGetSearchSuccessState());
      //print(value.data);
      search = value.data['articles'];
      print(search[0]);
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error));
      print("The error is ------------------->${error.toString()}");
    });
  }
}

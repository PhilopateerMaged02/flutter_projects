import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/NewsApp/search_screen/search_screen.dart';
//import 'package:news_app/modules/search_screen/search_screen.dart';
import 'package:news_app/shared/components/components.dart';

import '../../shared/cubit/cubit.dart';

class NewsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context); // Access cubit instance

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'News App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeAppMode();
                  print('Dark mode: ${cubit.isDark}'); // Debug print
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: NewsAppCubit.get(context).screens[NewsAppCubit.get(context).currindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: NewsAppCubit.get(context).currindex,
            items: NewsAppCubit.get(context).bottomItems,
            onTap: (index) {
              NewsAppCubit.get(context).changeIndex(index);
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/cubit.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/modules/NewsApp/search_screen/search_screen.dart';
import 'package:news_app/modules/ShopApp/search/search_screen.dart';
import 'package:news_app/modules/ShopApp/shop_login/login_screen.dart';
//import 'package:news_app/modules/shop_login/login_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class ShopScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopAppCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              fontFamily: 'Jannah',
              fontSize: 24),
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreenn());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: ShopAppCubit.get(context).BottomScreens[ShopAppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            showUnselectedLabels: true,
            onTap: (index)
            {
              ShopAppCubit.get(context).changeIndexButtom(index);
            },
              currentIndex: ShopAppCubit.get(context).currentIndex,
          items:
          [
            BottomNavigationBarItem(icon: Icon(
              Icons.home,
            ),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(
              Icons.apps,
            ),
                label: 'Categories'
            ),
            BottomNavigationBarItem(icon: Icon(
              Icons.favorite_border,
            ),
                label: 'Favorites'
            ),
            BottomNavigationBarItem(icon: Icon(
              Icons.settings,
            ),
                label: 'Settings'
            ),
          ]),
        );
      },
    );
  }
}
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsAppCubit,NewsAppStates>(
      listener:(context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: state is! NewsGetSportsLoadingState,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context , index) =>  defaultArticleItem(NewsAppCubit.get(context).sports[index],context),
            separatorBuilder: (context , index) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,),
            ),
            itemCount: NewsAppCubit.get(context).sports.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
        );
      },
    );
  }
}
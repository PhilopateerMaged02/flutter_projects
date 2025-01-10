import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    var searchController = TextEditingController();
    var list = NewsAppCubit.get(context).search;

    return BlocConsumer<NewsAppCubit,NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {  },
      builder: (BuildContext context, NewsAppStates state) =>Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                  controller: searchController,
                  input: TextInputType.text,
                  onValidator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Search must not be Empty';
                    }
                    return null;
                  },
                  text: 'Search',
                  prefix: Icons.search,
                  onChanged: (value)
                  {
                    NewsAppCubit.get(context).getSearchData(value);
                  }
              ),
            ),
          Expanded(
            child: ConditionalBuilder(
            condition: state is! NewsGetSearchLoadingState,
            builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context , index) =>  defaultArticleItem(NewsAppCubit.get(context).search[index],context),
            separatorBuilder: (context , index) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,),
            ),
            itemCount: NewsAppCubit.get(context).search.length,
                    ),
                    fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
                  ),
          ),
          ],
        ),
      ),
    );
  }
}
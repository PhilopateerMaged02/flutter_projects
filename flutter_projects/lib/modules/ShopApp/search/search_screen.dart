import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/shop_app/search_model.dart';
import 'package:news_app/modules/ShopApp/search/cubit/cubit.dart';
import 'package:news_app/modules/ShopApp/search/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreenn extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
        create: (context)=>ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit,ShopSearchStates>(
          builder: (context,state)=>buildSearch(context,state),
          listener:(context,state){}),
    );
  }
  Widget buildSearch(context,ShopSearchStates state)
  {
    return Scaffold(
      appBar:AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            defaultFormField(
                controller: searchController,
                input: TextInputType.text,
                onValidator: (value)
                {
                  if(value!.isEmpty)
                  {
                    return 'Enter anything to Search';
                  }
                },
                onFieldSubmitted: (value)
                {
                  if(formKey.currentState?.validate() ?? true)
                  {
                    ShopSearchCubit.get(context).search(searchController.text);
                  }
                },
                text: 'Search',
                prefix: CupertinoIcons.search),
            SizedBox(height: 20,),
            if(state is ShopSearchLoadingState)
            LinearProgressIndicator(color: Colors.blue,),
            SizedBox(height: 20,),
            ConditionalBuilder(
                condition: state is ShopSearchSuccessState,
                builder: (context)
                {
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index)=>buildFavItem(ShopSearchCubit.get(context).searchModel!.data!.data![index] as Product, context),
                        separatorBuilder: (context,index)=>Container(height: 1,width: double.infinity,color: Colors.black26,),
                        itemCount: ShopSearchCubit.get(context).searchModel!.data!.data!.length),
                  );
                },
                fallback:(context)=>Center(child: CircularProgressIndicator()),
              // (context)=>Center(child: Text(
                //     'No Product Called ${searchController.text}',
                //   style:TextStyle(color: Colors.grey,
                //   fontSize: 24,
                //   fontWeight: FontWeight.bold),
                // ),
                // ),
            ),
          ],
        ),
      ),
    );
  }
}
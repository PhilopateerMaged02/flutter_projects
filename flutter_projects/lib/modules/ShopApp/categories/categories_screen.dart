import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/cubit.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:  AppBar(),
      body: BlocConsumer<ShopAppCubit,ShopStates>(
          builder: (context,state)=>ListView.separated(
              itemBuilder: (context,index)=>buildListItem(ShopAppCubit.get(context).CategoriesModel!.data.dataList[index]),
              separatorBuilder: (context,index)=>Container(height: 1,width: double.infinity,color: Colors.black12,),
              itemCount: ShopAppCubit.get(context).CategoriesModel!.data.dataList.length),
          listener: (context,state){},
      ),
      );
  }
  Widget buildListItem(DataModel? model)
  {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model!.image),
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20,),
          Text(model.name,style: TextStyle(
            fontFamily: 'Jannah',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          Spacer(),
          Icon(Icons.arrow_forward_ios,
            size: 30,),
        ],
      ),
    );
  }
}
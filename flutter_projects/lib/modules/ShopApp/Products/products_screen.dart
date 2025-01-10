import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/cubit.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/models/shop_app/categories_model.dart';
import 'package:news_app/models/shop_app/home_model.dart';
import 'package:news_app/shared/components/components.dart';
//Home Screen ..
class ProductsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopAppCubit,ShopStates>(
      listener: (BuildContext context, state)
      {
        if(state is ShopLoadingChangeFavoritesSuccessState)
        {
          if(!state.FavoritesModel.status)
          {
            showToust(
                message: state.FavoritesModel.message,
                state: ToastStates.ERROR);
          }
          else
          {
            showToust(
                message: state.FavoritesModel.message,
                state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (BuildContext context, Object? state)
      {
        return ConditionalBuilder(
            condition: ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).CategoriesModel != null,
            builder: (context) => homeBuilder(ShopAppCubit.get(context).homeModel!,ShopAppCubit.get(context).CategoriesModel!,context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget homeBuilder(HomeModel model,categoriesModel catModel,context)
  {
   return SingleChildScrollView(
     physics: BouncingScrollPhysics(),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children:
       [
         CarouselSlider(
             items: model.data.banners.map((e)=>Image(
               image: NetworkImage('${e.image}'),
               width: double.infinity,
               fit: BoxFit.cover,
             ),).toList(),
             options: CarouselOptions(
                 autoPlay: true,
               reverse: false,
               height: 250,
               autoPlayInterval: Duration(seconds: 3),
               autoPlayAnimationDuration: Duration(seconds: 1),
               enableInfiniteScroll: true,
               scrollDirection: Axis.horizontal,
               viewportFraction: 1,
             ),
         ),
         SizedBox(height: 10,),
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('Categories',
               style: TextStyle(
                 fontWeight: FontWeight.w800,
                 fontSize: 24,
                 fontFamily: 'Jannah'
               ),),
               SizedBox(height: 20,),
               Container(
                 height: 100,
                 child: ListView.separated(
                   physics: BouncingScrollPhysics(),
                     //shrinkWrap: true,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index)=>buildCategories(catModel.data.dataList[index]),
                     separatorBuilder: (context,index)=>SizedBox(width: 10,),
                     itemCount: catModel.data.dataList.length),
               ),
               SizedBox(height: 20,),
               Text('New Products',
                 style: TextStyle(
                     fontWeight: FontWeight.w800,
                     fontSize: 24,
                     fontFamily: 'Jannah'
                 ),),
             ],
           ),
         ),
         Container(
           color: Colors.grey[200],
           child: GridView.count(
             mainAxisSpacing: .7,
             crossAxisSpacing: .7,
             childAspectRatio: 1/1.45,
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             crossAxisCount:2,
             children: List.generate(
                 model.data.Products.length,
                 (index)
                 {
                   return buildGridProduct(model.data.Products[index],context);
                 })
           ),
         ),
       ],
     ),
   );
  }
  Widget buildGridProduct(ProductsModel model,context)
  {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage('${model.image}'),
              width: double.infinity,
                height: 200,
                //fit: BoxFit.cover,
              ),
              if(model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(' Discount ',
                style: TextStyle(fontSize: 10,
                color: Colors.white,
                backgroundColor: Colors.red,),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}',
                maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.3
                ),),
                Row(
                  children: [
                    Text('${model.price.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: Colors.blue,
                      ),),
                    SizedBox(width: 5,),
                    if(model.discount != 0)
                    Text('${model.oldPrice.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                      ),),
                    Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          ShopAppCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: Icon(Icons.favorite,
                        color: ShopAppCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey,))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildCategories(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(model.image),
        height: 120,
        width: 120,
        fit: BoxFit.cover,),
      Container(
        child: Text(model.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.black54,
            color: Colors.white,
          ),),
      )
    ],
  );
}
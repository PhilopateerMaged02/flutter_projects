import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/cubit.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/models/shop_app/favorites_screen_model.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopStates>(
      builder: (context, state) => ConditionalBuilder(
      condition: state is! ShopLoadingFavoritesState,
      builder: (BuildContext context) {
        return listOfFavorites(context);
    },
      fallback: (BuildContext context)
      {
        return Center(child: CircularProgressIndicator());
      },),
    listener: (context, state){},
    );
  }

  Widget buildFavItem(FavoritesData model, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product?.image ?? ''),
                  width: 160,
                  height: 100,
                ),
                if (model.product?.discount != null && model.product!.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      '  Discount  ',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product?.name ?? 'No Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        model.product?.price?.toString() ?? '0',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 15),
                      if (model.product?.discount != null && model.product!.discount != 0)
                        Text(
                          model.product!.oldPrice.toString(),
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 9),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Icon(Icons.arrow_forward_ios),
                SizedBox(height: 40),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: ShopAppCubit.get(context).favorites[model.product!.id] ?? false
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () {
                    ShopAppCubit.get(context).changeFavorites(model.product?.id ?? 000);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget myDivider() {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(height: 1, width: double.infinity, color: Colors.black12),
        SizedBox(height: 10),
      ],
    );
  }

  Widget listOfFavorites(context) {
    var favoritesData = ShopAppCubit.get(context).favoritesScreenmodel?.data?.data;

    if (favoritesData == null || favoritesData.isEmpty) {
      return Center(child: Text('No favorites found.'));
    }

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildFavItem(favoritesData[index] as FavoritesData, context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: favoritesData.length,
    );
  }
}

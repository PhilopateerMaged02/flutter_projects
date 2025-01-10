class HomeModel
{
  late final bool status;
  late final HomeModelData data;
  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = HomeModelData.fromJson(json['data']);
  }
}
class HomeModelData
{
  late List<BannersModel> banners = [];
  late List<ProductsModel> Products= [];
  HomeModelData.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element)
    {
      Products.add(ProductsModel.fromJson(element));
    });
  }
}
class BannersModel
{
  late int id;
  late String image;
  BannersModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    image = json['image'];
  }
}
class ProductsModel
{
  late int id;
  late dynamic oldPrice;
  late dynamic price;
  late int discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  ProductsModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    oldPrice = json['old_price'];
    price = json['price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
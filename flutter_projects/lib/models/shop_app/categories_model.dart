class categoriesModel
{
  late bool status;
  late categoriesModelData data;

  categoriesModel.fromJson(Map<String , dynamic>json)
  {
    status = json['status'];
    data = categoriesModelData.fromJson(json['data']);
  }
}
class categoriesModelData
{
  late int currentPage;
  List<DataModel> dataList = [];
  categoriesModelData.fromJson(Map<String , dynamic>json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element)
    {
      dataList.add(DataModel.fromJson(element));
    });
  }

}
class DataModel
{
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
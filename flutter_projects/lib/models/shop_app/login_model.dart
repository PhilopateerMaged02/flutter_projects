class ShoploginModel
{
bool? status;
String? message;
ShopUserData? data;

  ShoploginModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data']!= null ? ShopUserData.fromJson(json['data']) : null;
  }
}
class ShopUserData
{
  int? id;
  String? name;
  String? email;
  String? image;
  String? phone;
  int? points;
  int? credit;
  String? token;

  ShopUserData.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    credit = json['credit'];
    points = json['points'];
    token = json['token'];
    image = json['image'];
  }
}
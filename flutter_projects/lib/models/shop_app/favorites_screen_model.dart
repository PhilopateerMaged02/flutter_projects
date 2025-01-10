class FavoritesScreenModel {
  bool? status;
  String? message;
  Data? data;

  FavoritesScreenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] ?? ''; // Provide a default value if 'message' is null
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<FavoritesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoritesData>[]; // Make sure this is a list of FavoritesData
      json['data'].forEach((v) {
        data!.add(FavoritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'] ?? ''; // Provide a default empty string
    path = json['path'] ?? '';
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'] ?? '';
    to = json['to'];
    total = json['total'];
  }
}

class FavoritesData {
  int? id;
  Product? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  late String image;
  late String name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'] ?? ''; // Provide a default empty string if null
    name = json['name'] ?? ''; // Handle possible null values
    description = json['description'] ?? ''; // Provide default empty string if null
  }
}

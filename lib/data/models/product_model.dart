import 'category_model.dart';

class ProductDataModel {
  ProductDataModel({
    required this.currentPage,
    required this.data,
  });

  final int currentPage;
  final List<ProductModel> data;

  factory ProductDataModel.fromJson(Map<String, dynamic> json) => ProductDataModel(
    currentPage: json["current_page"],
    data: List<ProductModel>.from(json["data"].map((x) => ProductModel.fromJson(x))),
  );

}

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.tags,
    required this.categoriesId,
    required this.category,
    required this.galleries,
  });

  final int id;
  final String name;
  final int price;
  final String description;
  final dynamic tags;
  final num categoriesId;
  final CategoryModel category;
  final List<Gallery> galleries;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    tags: json["tags"],
    categoriesId: json["categories_id"],
    category: CategoryModel.fromJson(json["category"]),
    galleries: List<Gallery>.from(json["galleries"].map((x) => Gallery.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price
  };


}

class Gallery {
  Gallery({
    required this.id,
    required this.productsId,
    required this.url,
  });

  final num id;
  final num productsId;
  final String url;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    id: json["id"],
    productsId: json["products_id"],
    url: json["url"],
  );


}

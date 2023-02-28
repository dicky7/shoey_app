import 'package:shoes_app/data/models/catagory_model.dart';

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

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
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
  final double price;
  final String description;
  final dynamic tags;
  final int categoriesId;
  final CategoryModel category;
  final List<GalleryModel> galleries;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    tags: json["tags"],
    categoriesId: json["categories_id"],
    category: CategoryModel.fromJson(json["category"]),
    galleries: List<GalleryModel>.from(json["galleries"].map((x) => GalleryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "tags": tags,
    "categories_id": categoriesId,
    "category": category.toJson(),
    "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
  };
}

class GalleryModel {
  GalleryModel({
    required this.id,
    required this.productsId,
    required this.url,
  });

  final int id;
  final int productsId;
  final String url;

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
    id: json["id"],
    productsId: json["products_id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "products_id": productsId,
    "url": url,
  };
}

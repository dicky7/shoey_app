import 'dart:convert';

class CategoryDataModel {
  CategoryDataModel({
    required this.currentPage,
    required this.data,
  });

  final int currentPage;
  final List<CategoryModel> data;

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
    currentPage: json["current_page"],
    data: List<CategoryModel>.from(json["data"].map((x) => CategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    this.isSeledted = false
  });

  final int id;
  final String name;
  bool isSeledted;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

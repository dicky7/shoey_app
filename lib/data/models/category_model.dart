
class CategoryDataModel {
  CategoryDataModel({
    required this.currentPage,
    required this.data,
  });

  final num currentPage;
  final List<CategoryModel> data;

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
    currentPage: json["current_page"],
    data: List<CategoryModel>.from(json["data"].map((x) => CategoryModel.fromJson(x))),
  );
}

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    this.isSelected = false
  });

  final int id;
  final String name;
  bool isSelected;

  //this fuction setSelected boolean
  CategoryModel setSelected(bool isSelected) {
    return CategoryModel(
      id: id,
      name: name,
      isSelected: isSelected,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
  );


}
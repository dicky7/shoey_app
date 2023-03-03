import 'package:shoes_app/data/models/product_model.dart';

class ProductTable{
  ProductTable({
    required this.id,
    required this.name,
    required this.price,
    required this.photo
  });

  final int id;
  final String name;
  final String photo;
  final int price;


  factory ProductTable.fromMap(Map<String, dynamic> map) => ProductTable(
    id: map["id"],
    name: map["name"],
    photo: map['photo'],
    price: map["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    'photo': photo,
    "price": price,
  };
}
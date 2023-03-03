class CartTable{
  CartTable({
    required this.id,
    required this.name,
    required this.photo,
    required this.price,
    required this.quantity});

  final int id;
  final String name;
  final String photo;
  final int price;
  final int quantity;


  factory CartTable.fromMap(Map<String, dynamic> map) => CartTable(
    id: map["id"],
    name: map["name"],
    photo: map['photo'],
    price: map["price"],
    quantity: map["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    'photo': photo,
    "price": price,
    "quantity": quantity
  };

  CartTable setUpdateCart(int quantity) {
    return CartTable(
      id: id,
      name: name,
      photo: photo,
      price: price,
      quantity: quantity ,
    );
  }
}
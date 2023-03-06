

class TransactionDataModel {
  TransactionDataModel({
    required this.currentPage,
    required this.data,
  });

  final int? currentPage;
  final List<TransactiontModel> data;

  factory TransactionDataModel.fromJson(Map<String, dynamic> json) => TransactionDataModel(
    currentPage: json["current_page"],
    data: List<TransactiontModel>.from(json["data"].map((x) => TransactiontModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TransactiontModel {
  TransactiontModel({
    required this.id,
    required this.usersId,
    required this.address,
    required this.totalPrice,
    required this.shippingPrice,
    required this.status,
    required this.items,
  });

  final int id;
  final int usersId;
  final String address;
  final int totalPrice;
  final int shippingPrice;
  final String status;
  final List<TransactionItemModel> items;

  factory TransactiontModel.fromJson(Map<String, dynamic> json) => TransactiontModel(
    id: json["id"],
    usersId: json["users_id"],
    address: json["address"],
    totalPrice: json["total_price"],
    shippingPrice: json["shipping_price"],
    status: json["status"],
    items: List<TransactionItemModel>.from(json["items"].map((x) => TransactionItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "users_id": usersId,
    "address": address,
    "total_price": totalPrice,
    "shipping_price": shippingPrice,
    "status": status,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class TransactionItemModel {
  TransactionItemModel({
    required this.id,
    required this.usersId,
    required this.productsId,
    required this.transactionsId,
    required this.quantity,
    required this.product,
  });

  final int id;
  final int usersId;
  final int productsId;
  final int transactionsId;
  final int quantity;
  final TransactionProductModel product;

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) => TransactionItemModel(
    id: json["id"],
    usersId: json["users_id"],
    productsId: json["products_id"],
    transactionsId: json["transactions_id"],
    quantity: json["quantity"],
    product: TransactionProductModel.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "users_id": usersId,
    "products_id": productsId,
    "transactions_id": transactionsId,
    "quantity": quantity,
    "product": product.toJson(),
  };
}

class TransactionProductModel {
  TransactionProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoriesId,
  });

  final int id;
  final String name;
  final int price;
  final String description;
  final int categoriesId;

  factory TransactionProductModel.fromJson(Map<String, dynamic> json) => TransactionProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    categoriesId: json["categories_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "categories_id": categoriesId,
  };
}

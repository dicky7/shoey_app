
class CheckoutOrderModel {
  CheckoutOrderModel({
    required this.address,
    required this.items,
    required this.status,
    required this.totalPrice,
    required this.shippingPrice,
  });

  final String address;
  final List<CheckoutItems> items;
  final String status;
  final int totalPrice;
  final int shippingPrice;


  Map<String, dynamic> toJson() => {
    "address": address,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "status": status,
    "total_price": totalPrice,
    "shipping_price": shippingPrice,
  };
}

class CheckoutItems {
  CheckoutItems({
    required this.id,
    required this.quantity,
  });

  final int id;
  final int quantity;

  factory CheckoutItems.fromJson(Map<String, dynamic> json) => CheckoutItems(
    id: json["id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
  };
}

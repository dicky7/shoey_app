// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'package:shoes_app/data/models/product_model.dart';

//This code defines a generic class BaseResponse that takes a type parameter T

//Using a generic class like BaseResponse can make our code more flexible and reusable,
// as we can create instances of the class for different types of data without having to create a
// separate class for each response type. It also allows us to write generic code that can work
// with responses of different types.
class BaseResponse<T> {
  final Meta meta;
  final T data;

  BaseResponse({
    required this.meta,
    required this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    meta: Meta.fromJson(json["meta"]),
    data: json["data"]
  );
}

class Meta {
  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  final int code;
  final String status;
  final String message;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    code: json["code"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
  };
}

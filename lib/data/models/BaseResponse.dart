// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'package:shoes_app/data/models/product_model.dart';

class BaseResponse {
  BaseResponse({
    required this.meta,
    required this.data,
  });

  final Meta meta;
  final ProductDataModel data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    meta: Meta.fromJson(json["meta"]),
    data: ProductDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": data.toJson(),
  };
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

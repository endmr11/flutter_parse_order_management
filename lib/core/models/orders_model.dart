import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
    OrdersModel({
        required this.id,
        required this.prod_id,
        required this.customer,
        required this.content,
    });

    int? id;
    int? prod_id;
    String? customer;
    String? content;

    factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json["id"],
        prod_id: json["prod_id"],
        customer: json["customer"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "prod_id": prod_id,
        "customer": customer,
        "content": content,
    };
}

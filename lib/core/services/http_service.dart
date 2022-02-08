import 'package:dio/dio.dart';
import 'package:flutterlivequery/core/models/orders_model.dart';
import 'package:flutterlivequery/core/models/products_model.dart';

class HttpService {
  HttpService._();
  static final HttpService _instance = HttpService._();
  static HttpService get i => _instance;

  var dio = Dio();
  Future<List<ProductsModel>?> getProducts() async {
    Response response;
    try {
      response = await dio.get('http://localhost:3000/products');
      var nResponse = response.data as List<dynamic>;
      print(">>>>>> RESPONSE PRODUCTS: $nResponse");
      List<ProductsModel> products = [];
      for (var prdct in nResponse) {
        var product = ProductsModel(
            id: prdct['id'], name: prdct['name'], price: prdct['price']);
        products.add(product);
      }
      return products;
    } catch (e) {
      print("Products Get Error:$e");
      return [];
    }
  }

  Future<List<OrdersModel>?> getOrders() async {
    Response response;
    try {
      response = await dio.get('http://localhost:3000/orders');
      var nResponse = response.data as List<dynamic>;
      print(">>>>>> RESPONSE ORDERS: $nResponse");
      List<OrdersModel> orders = [];
      for (var ordrs in nResponse) {
        var order = OrdersModel(
            id: ordrs['id'],
            prod_id: ordrs['prod_id'],
            customer: ordrs['customer'],
            content: ordrs['content']);
        orders.add(order);
      }
      return orders;
    } catch (e) {
      print("Orders Get Error:$e");
      return [];
    }
  }

  Future<bool> postOrder(Map<String,dynamic> data) async {
    Response response;
    try {
      response = await dio.post('http://localhost:3000/orders', data: data);
      print(">>>>>> RESPONSE: $response");
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print("Post Order Error:$e");
      return false;
    }
  }
}

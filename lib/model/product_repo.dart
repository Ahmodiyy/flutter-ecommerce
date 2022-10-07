import 'dart:convert';

import 'package:ecommerce/class/ordered_product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../class/product.dart';

class ProductRepo {
  Future<List<Product>> fetchProduct(http.Client client) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    final response = await client.get(
        Uri.parse(
          'http://localhost:8082/api/products',
        ),
        headers: header);

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseProduct, response.body);
  }

// A function that converts a response body into a List<Product>.
  List<Product> parseProduct(String responseBody) {
    final List<Map<String, dynamic>> parsed =
        jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map((json) {
      return Product(
          id: json['id'],
          price: json['price'],
          description: json['description'],
          image: json['image'],
          name: json['name']);
    }).toList();
  }

  Future<List<OrderedProduct>> fetchOrders(
      http.Client client, String userId) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    print('userid $userId');
    final response = await client.get(
        Uri.parse(
          'http://localhost:8082/api/getOrders/$userId',
        ),
        headers: header);

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseOrder, response.body);
  }

  List<OrderedProduct> parseOrder(String responseBody) {
    final List<Map<String, dynamic>> parsed =
        jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map((json) {
      debugPrint('movie: $json');
      return OrderedProduct(
          orderId: json['id'],
          quantity: json['quantity'],
          productId: json['product']['id']);
    }).toList();
  }
}

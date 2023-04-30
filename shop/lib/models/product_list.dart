import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
//import 'package:shop/data/dummy_data.dart';
import '../utils/constants.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final _apiURL = Constants.productBaseURL;
  final String _token;
  final String _userId;

  ProductList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  List<Product> _items = []; //dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> loadProducts() async {
    _items = []; // _items.clear(); // limpa a lista
    final response = await http.get(
      Uri.parse('$_apiURL.json?auth=$_token'),
    );

    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constants.userFavoriteUrl}/$_userId.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favProducts =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      final isFavorite = favProducts[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite, //productData['isFavorite'],
        ),
      );
    });

    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_apiURL/${product.id}.json?auth=$_token'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );

      _items[index] = product; // substituindo o item pelo item alterado
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      //_items.removeAt(index);
      //_items.removeWhere((p) => p.id == product.id); // poderia ser assim também
      notifyListeners();

      final response = await http.delete(
        Uri.parse('$_apiURL/${product.id}.json?auth=$_token'),
      );

      // Erro que temos um problema
      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
            msg: 'Não foi possível excluir o produto!',
            statusCode: response.statusCode);
      }
    }
  }

  Future<void> addProduct(Product product) async {
    final future = await http.post(
      Uri.parse('$_apiURL.json?auth=$_token'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        //"isFavorite": product.isFavorite
      }),
    );

    //print(jsonDecode(future.body));
    final id = jsonDecode(future.body)['name'];

    final finalProduct = Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite);

    _items.add(finalProduct);
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }
}

/*
bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((product) => product.isFavorite).toList();
    }

    return [..._items];
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

*/

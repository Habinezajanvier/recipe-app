import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exceptions.dart';

class Recipies with ChangeNotifier {
  final String basicUrl =
      'https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=under_30_minutes';

  List<String> _recipies;

  List<String> get recipies {
    return [..._recipies];
  }

  Recipies(this._recipies);

  Future<void> getAllRecipies() async {
    final url = Uri.parse(basicUrl);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-rapidapi-host': 'tasty.p.rapidapi.com',
          'x-rapidapi-key': 'b9cbb96bc3mshb418703bc770446p17f6fdjsne8d1a4fb225c'
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      for (var recipe in responseData['data']) {
        _recipies = [..._recipies, recipe['name']];
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}

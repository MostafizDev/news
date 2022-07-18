import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapi/Model/NewsListModel.dart';

import 'package:http/http.dart' as http;

class GetData extends ChangeNotifier {
  NewsListModel? newsListModel;

  Future getNewsInfo() async {
    newsListModel = null;

    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2022-06-18&sortBy=publishedAt&apiKey=9289f6359b034bbead38171c558b85c7'));

    var data = json.decode(response.body);

    print(data.toString());

    newsListModel = NewsListModel.fromJson(data);

    notifyListeners();
  }
}

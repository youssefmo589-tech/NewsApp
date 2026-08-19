import 'package:flutter/material.dart';
import 'package:news/Modules/Articleclass.dart';
import 'package:news/Modules/Home/CategoryModel.dart';
import 'package:news/Modules/source_model.dart';
import 'package:news/core/network/http_requests.dart';

class HomeViewModel extends ChangeNotifier {
  List<CategoryModel> categories = [
    CategoryModel(
      name: "General",
      imagepath: "assets/images/general.png",
      id: "general",
    ),
    CategoryModel(
      name: "Business",
      id: "bussiness",
      imagepath: "assets/images/busniess.png",
    ),
    CategoryModel(
      name: "Sports",
      id: "sports",
      imagepath: "assets/images/sport.png",
    ),
    CategoryModel(
      name: "Technology",
      id: "technology",
      imagepath: "assets/images/technology.png",
    ),
    CategoryModel(
      name: "Entertainment",
      id: "entertainment",
      imagepath: "assets/images/entertainment.png",
    ),

    CategoryModel(
      name: "Health",
      id: "health",
      imagepath: "assets/images/helth.png",
    ),

    CategoryModel(
      name: "Science",
      id: "science",
      imagepath: "assets/images/science.png",
    ),
  ];

  List<CategoryModel> getcategories() => categories;

  CategoryModel? _selectedcategory;

  int _selectedindex = 0;

  List<Source> _sources = [];

  List<Source> get sources => _sources;

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  int getselectedindex() => _selectedindex;

  void changetabindex(int index) {
    _selectedindex = index;
    getallarticle();
    notifyListeners();
  }

  CategoryModel? selectedcategory() => _selectedcategory ?? null;

  void changeselectedcategory(CategoryModel? category) {
    if (category == null) {
      _selectedcategory = null;
      notifyListeners();
      return;
    }
    _selectedcategory = category;
    notifyListeners();
  }

  Future<void> getallsources() async {
    final data = await HttpRequestService.getAllSources(_selectedcategory!.id);
    _sources = data;
    notifyListeners();
  }

  Future<void> getallarticle() async {
    final data = await HttpRequestService.getAllArticles(
      _sources[_selectedindex].id,
    );
    _articles = data;
    notifyListeners();
  }
}

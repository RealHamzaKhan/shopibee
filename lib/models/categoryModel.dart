// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    required this.categories,
  });

  List<Category> categories;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.name,
    required this.subcategories,
  });

  String name;
  List<String> subcategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    subcategories: List<String>.from(json["subcategories"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x)),
  };
}

import 'package:flutter/material.dart';

class Category {
  Category({required this.categoryName, required this.icon});
  String categoryName;
  String icon;

  Map<String, dynamic> toFirestore(){
    return {
      'categoryName': categoryName,
      'icon': icon.toString()
    };
  }
}
//Dummy data.
List<Category> expenseCategories = [
  Category(categoryName: 'Clothing', icon: 'assets/imgs_category/clothes.png'),
  Category(categoryName: 'Car', icon: 'assets/imgs_category/car.png'),
  Category(categoryName: 'House', icon: 'assets/imgs_category/house.png'),
  Category(categoryName: 'Food', icon: 'assets/imgs_category/food.png'),
];
  List<Category> incomeCategories = [
    Category(categoryName: 'Salary', icon: 'assets/imgs_category/salary.png'),
    Category(categoryName: 'Dividend Yield', icon: 'assets/imgs_category/dividend.png'),
    Category(categoryName: 'Investment', icon: 'assets/imgs_category/investment.png'),
  ];
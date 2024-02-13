

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/models/category_model.dart';
import 'package:khlfan_shtain/viewmodel/category_viewmodel.dart';

final categoryProvider = ChangeNotifierProvider<CategoryProvider>((ref) {
  return CategoryProvider();
});
class CategoryProvider extends ChangeNotifier {
CategoryViewModel categoryViewModel=CategoryViewModel();
   addCategories(String name) {

     categoryViewModel.addCategories(name);

     notifyListeners();
  }

Future<List<CategoryModel>> getCategories() {
  return  categoryViewModel.getCategories();

  }

  List<CategoryModel> get categories => categoryViewModel.categories;
}
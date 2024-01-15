
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/category_model.dart';
import 'local_storage_viewmodel.dart';
final categoryViewModelProvider = AutoDisposeChangeNotifierProvider<CategoryViewModel>((ref) {
  return CategoryViewModel();
});
class CategoryViewModel extends ChangeNotifier {
  LocalStorageViewModel local=LocalStorageViewModel();
  List<CategoryModel> categories = <CategoryModel>[];

  Future<void> addCategories(String name) async {

    String id=const Uuid().v4();
    categories.add(CategoryModel(id: id, name: name));
   await local.addData(collectionName: "categories", data: {"id":id,"name":name}, docID: id);

    notifyListeners();
  }


  Future<List<CategoryModel>> getCategories() async {
    final Map<String,dynamic>value = await local.getData(collectionName: "categories");
    categories.clear();

    if (value['status'] != 'empty') {
      value.forEach((key, value) {
        categories.add(CategoryModel.fromJson(value));
        notifyListeners();
      });
    }

  return categories;
  }
}

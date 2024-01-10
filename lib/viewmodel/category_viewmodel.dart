
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/category_model.dart';
final categoryViewModelProvider = AutoDisposeChangeNotifierProvider<CategoryViewModel>((ref) {
  return CategoryViewModel();
});
class CategoryViewModel extends ChangeNotifier {
  List<CategoryModel> categories = <CategoryModel>[];

final firebaseFirestore = FirebaseFirestore.instance;
  Future<void> addCategories(String name) async {
    String id=Uuid().v4();
    categories.add(CategoryModel(id: id, name: name));
 firebaseFirestore.collection("categories").doc(id).set({
      "id":id,
      "name":name
    });
    notifyListeners();
  }


  Future<List<CategoryModel>> getCategories() async {
    final value = await firebaseFirestore.collection("categories").get();
    categories.clear();
    value.docs.forEach((element) {
      categories.add(CategoryModel.fromJson(element.data()));
      notifyListeners();
    });
  return categories;
  }
}

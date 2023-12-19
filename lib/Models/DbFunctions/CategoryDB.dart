// ignore_for_file: file_names, non_constant_identifier_names, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/Models/modelsFunc/CategoryModel.dart';
import 'package:hive/hive.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = 'category_db';

abstract class CategoryDB {
  Future<List<CategoryModel>> getcategory();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String CategoryID);
}

class CategoryDbFun implements CategoryDB {
  CategoryDbFun._internal();
  static CategoryDbFun instance = CategoryDbFun._internal();
  factory CategoryDbFun() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> IncomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> ExpenseCategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categorydb.put(value.id, value);
    refreshui();
  }

  @override
  Future<List<CategoryModel>> getcategory() async {
    final categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categorydb.values.toList();
  }

  refreshui() async {
    final allcategory = await getcategory();
    IncomeCategoryList.value.clear();
    ExpenseCategoryList.value.clear();
    await Future.forEach(
      allcategory,
      (CategoryModel modelCategory) {
        if (modelCategory.type == CategoryType.income) {
          IncomeCategoryList.value.add(modelCategory);
        } else {
          ExpenseCategoryList.value.add(modelCategory);
        }
      },
    );
    // ignore: invalid_use_of_visible_for_testing_member
    IncomeCategoryList.notifyListeners();
    ExpenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String CategoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(CategoryID);
    refreshui();
  }

  delete() async {
    final categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    categorydb.clear();
  }
}

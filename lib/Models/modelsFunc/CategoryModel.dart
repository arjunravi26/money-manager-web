// ignore_for_file: file_names

import 'package:hive/hive.dart';

part 'CategoryModel.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;

  CategoryModel({
    required this.name,
    required this.type,
    required this.id,
    this.isDeleted = false,
  });
  @override
  String toString() {
    return '$name $type';
  }
}

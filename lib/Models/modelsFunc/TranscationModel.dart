// ignore_for_file: file_names

import 'package:flutter_application_1/Models/modelsFunc/CategoryModel.dart';
import 'package:hive/hive.dart';
part 'TranscationModel.g.dart';

// @HiveType(typeId: 2)
// enum CategoryType {
//   @HiveField(0)
//   income,
//   @HiveField(1)
//   expense,
// }

@HiveType(typeId: 3)
class TranscaitonModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String purpose;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final bool isDeleted;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final CategoryType type;
  @HiveField(6)
  final CategoryModel category;

  TranscaitonModel({
    required this.purpose,
    required this.amount,
    this.isDeleted = false,
    required this.date,
    required this.type,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

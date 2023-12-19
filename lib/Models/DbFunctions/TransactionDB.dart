// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names, camel_case_types, invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Models/modelsFunc/TranscationModel.dart';
import 'package:hive/hive.dart';

const Transcation_db = 'tranncation';

abstract class Transcationfun {
  Future<void> addtrans(TranscaitonModel model);
  Future<List<TranscaitonModel>> gettrans();
  Future<void> dletetrans(String Id);
}

class transfun implements Transcationfun {
  transfun._internal();
  static transfun instance = transfun._internal();
  factory transfun() {
    return instance;
  }

  ValueNotifier<List<TranscaitonModel>> TranscationListener = ValueNotifier([]);
  @override
  Future<void> addtrans(TranscaitonModel model) async {
    final transDB = await Hive.openBox<TranscaitonModel>(Transcation_db);
    transDB.put(model.id, model);
  }

  @override
  Future<List<TranscaitonModel>> gettrans() async {
    final transDB = await Hive.openBox<TranscaitonModel>(Transcation_db);
    return transDB.values.toList();
  }

  getui() async {
    final lists = await gettrans();
    lists.sort((first, second) => second.date.compareTo(first.date));
    TranscationListener.value.clear();
    TranscationListener.value.addAll(lists);
    // ignore: invalid_use_of_protected_member
    TranscationListener.notifyListeners();
  }

  @override
  Future<void> dletetrans(String Id) async {
    final transDB = await Hive.openBox<TranscaitonModel>(Transcation_db);
    await transDB.delete(Id);
    getui();
  }
}

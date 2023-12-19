// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/DbFunctions/TransactionDB.dart';
import 'package:flutter_application_1/Models/modelsFunc/CategoryModel.dart';
import 'package:flutter_application_1/Models/modelsFunc/TranscationModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class Transationscreen extends StatelessWidget {
  const Transationscreen({super.key});
  // late final data;

  @override
  Widget build(BuildContext context) {
    transfun().getui();
    return ValueListenableBuilder(
      valueListenable: transfun.instance.TranscationListener,
      builder: ((BuildContext ctx, List<TranscaitonModel> value, _) {
        return ListView.separated(
            itemBuilder: ((ctx, index) {
              final data = value[index];
              return Slidable(
                startActionPane:
                    ActionPane(motion: const DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: ((cxt) {
                      transfun.instance.dletetrans(data.id!);
                    }),
                    icon: Icons.delete,
                  )
                ]),
                key: Key(data.id!),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundColor: data.type == CategoryType.income
                          ? Colors.green
                          : Colors.red,
                      child: Text(
                        parseDate(data.date),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    title: Text(data.purpose),
                    subtitle: Text(data.amount.toString()),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: (() {
                        transfun().dletetrans(data.id!);
                      }),
                    ),
                  ),
                ),
              );
            }),
            separatorBuilder: ((ctx, index) {
              return const Divider();
            }),
            itemCount: value.length);
      }),
    );
  }

  String parseDate(DateTime date) {
    final dates = DateFormat.MMMd().format(date);
    final dateSplit = dates.split(' ');
    return '${dateSplit.last}\n${dateSplit.first}';
  }
}

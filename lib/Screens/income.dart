import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/DbFunctions/CategoryDB.dart';
import 'package:flutter_application_1/Models/modelsFunc/CategoryModel.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDbFun().IncomeCategoryList,
        builder: ((BuildContext ctx, List<CategoryModel> values, _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final category = values[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        //CategoryDbFun().delete();
                        CategoryDbFun().deleteCategory(category.id);
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: values.length);
        }));
  }
}

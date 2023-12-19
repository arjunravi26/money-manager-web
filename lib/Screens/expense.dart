import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/DbFunctions/CategoryDB.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDbFun().ExpenseCategoryList,
        builder: ((context, value, child) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final category = value[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        CategoryDbFun().deleteCategory(category.id);
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: value.length);
        }));
  }
}

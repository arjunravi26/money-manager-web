// ignore_for_file: file_names, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/DbFunctions/CategoryDB.dart';
import 'package:flutter_application_1/Models/modelsFunc/CategoryModel.dart';

final _nameController = TextEditingController();
ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);
showCategoryaddpopup(BuildContext ctx) async {
  showDialog(
    context: ctx,
    builder: (ctx1) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              label: Text('Category Name'),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {},
          ),
          Row(
            children: const [
              Radiobuttons(title: 'Income', type: CategoryType.income),
              Radiobuttons(title: 'Expense', type: CategoryType.expense)
            ],
          ),
          ElevatedButton(
            onPressed: () {
              final name = _nameController.text;
              if (name.isEmpty) {
                return;
              }
              final category = CategoryModel(
                  name: name,
                  type: selectedCategory.value,
                  id: DateTime.now().millisecondsSinceEpoch.toString());

              CategoryDbFun().insertCategory(category);
              Navigator.of(ctx1).pop();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

class Radiobuttons extends StatelessWidget {
  final String title;
  final CategoryType type;
  const Radiobuttons({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategory,
      builder: ((context, newvalues, child) {
        return Row(
          children: [
            Radio(
              value: type,
              groupValue: newvalues,
              onChanged: ((values) {
                if (values == null) {
                  return;
                }
                selectedCategory.value = values;
                selectedCategory.notifyListeners();
              }),
            ),
            Text(title),
          ],
        );
      }),
    );
  }
}

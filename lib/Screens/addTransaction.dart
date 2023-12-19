// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/DbFunctions/CategoryDB.dart';
import 'package:flutter_application_1/Models/DbFunctions/TransactionDB.dart';
import 'package:flutter_application_1/Models/modelsFunc/CategoryModel.dart';
import 'package:flutter_application_1/Models/modelsFunc/TranscationModel.dart';

class AddTranscation extends StatefulWidget {
  const AddTranscation({super.key});

  @override
  State<AddTranscation> createState() => _AddTranscationState();
}

class _AddTranscationState extends State<AddTranscation> {
  @override
  void initState() {
    CategoryDbFun().refreshui();
    super.initState();
  }

  final _textcontroller1 = TextEditingController();
  final _textcontroller2 = TextEditingController();
  DateTime? _selectedDate;
  CategoryType? _Cattype;
  CategoryModel? _Catmodel;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(' Add Transcation ')),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textcontroller1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.5),
                  ),
                  labelText: 'Purpose',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textcontroller2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.5),
                  ),
                  labelText: 'Amount',
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final selectedDatetemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(
                    const Duration(days: 30),
                  ),
                  lastDate: DateTime.now().add(
                    const Duration(days: 30),
                  ),
                );
                if (selectedDatetemp == null) {
                  return;
                } else {
                  setState(() {
                    _selectedDate = selectedDatetemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _Cattype,
                        onChanged: ((newvalue) {
                          setState(() {
                            _Cattype = newvalue;
                            name = null;
                          });
                        })),
                    const Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _Cattype,
                        onChanged: ((newvalue) {
                          setState(() {
                            name = null;
                            _Cattype = newvalue;
                          });
                        })),
                    const Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton(
              value: name,
              items: _Cattype == CategoryType.income
                  ? CategoryDbFun().IncomeCategoryList.value.map((e) {
                      return DropdownMenuItem(
                          onTap: () {
                            _Catmodel = e;
                          },
                          value: e.name,
                          child: Text(e.name));
                    }).toList()
                  : _Cattype == CategoryType.expense
                      ? CategoryDbFun().ExpenseCategoryList.value.map((e) {
                          return DropdownMenuItem(
                              onTap: () {
                                _Catmodel = e;
                              },
                              value: e.name,
                              child: Text(e.name));
                        }).toList()
                      : null,
              onChanged: ((values) {
                setState(() {
                  name = values.toString();
                });
              }),
              hint: Text(name == null ? 'Select' : name!),
            ),
            ElevatedButton(
                onPressed: () {
                  addButton();
                  transfun().getui();
                  Navigator.pop(context);
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }

  addButton() async {
    final text1 = _textcontroller1.text;
    final text2 = _textcontroller2.text;
    final parsedamount = double.tryParse(text2);
    if (text1.isEmpty || text2.isEmpty) {
      return;
    }
    if (name == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    final model = TranscaitonModel(
        purpose: text1,
        amount: parsedamount!,
        date: _selectedDate!,
        type: _Cattype!,
        category: _Catmodel!);
    transfun.instance.addtrans(model);
  }
}

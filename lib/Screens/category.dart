import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/DbFunctions/CategoryDB.dart';
import 'package:flutter_application_1/Screens/expense.dart';
import 'package:flutter_application_1/Screens/income.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({super.key});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDbFun().refreshui();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          //onTap: (value) {},
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expense',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              IncomeScreen(),
              ExpenseScreen(),
            ],
          ),
        )
      ],
    );
  }
}

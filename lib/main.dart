import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/modelsFunc/CategoryModel.dart';
import 'package:flutter_application_1/Models/modelsFunc/TranscationModel.dart';
import 'package:flutter_application_1/Screens/Transation.dart';
import 'package:flutter_application_1/Screens/addTransaction.dart';
import 'package:flutter_application_1/Screens/category.dart';
import 'package:flutter_application_1/Screens/popupCategory.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TranscaitonModelAdapter().typeId)) {
    Hive.registerAdapter(TranscaitonModelAdapter());
  }

  runApp(const MyApp());
}

ValueNotifier<int> _controller = ValueNotifier(0);
final _pages = [
  const Transationscreen(),
  const Categoryscreen(),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "MONEY MANAGER",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (_controller.value == 0) {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx2) {
              return const AddTranscation();
            }));
          } else {
            showCategoryaddpopup(context);
          }
        },
      ),
      bottomNavigationBar: const NavigatonbarScreen(),
      body: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (BuildContext ctx, int value, _) {
          return _pages[_controller.value];
        },
      ),
    );
  }
}

class NavigatonbarScreen extends StatelessWidget {
  const NavigatonbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (BuildContext ctx, int value, _) {
          return BottomNavigationBar(
            currentIndex: _controller.value,
            onTap: (value) {
              _controller.value = value;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Transaction"),
              BottomNavigationBarItem(
                label: "category",
                icon: Icon(Icons.category),
              )
            ],
          );
        },
      ),
    );
  }
}

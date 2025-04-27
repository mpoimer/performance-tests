import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:performance_flutter/test_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Performance Test',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TestModel> _testModels = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await rootBundle.loadString('assets/files/test.json');
    final data = jsonDecode(response);
    var result = <TestModel>[];

    for (var item in data) {
      final testModel = TestModel.fromJson(item);
      result.add(testModel);
    }
    setState(() {
      _testModels = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_testModels.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Items: ${_testModels.length}')),
        body: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Text('this is a test');
                } else {
                  return Text(_testModels[index].name);
                }
              },
              itemCount: _testModels.length + 1,
            ),
          ],
        ),
      );
    }
  }
}

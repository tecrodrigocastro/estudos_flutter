import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  List<String> name = [
    'Sarah',
    'Janine',
    'William',
  ];
  List<String> email = [
    'Sarah@gmail.com',
    'Janine@gmial.com',
    'William@gmail.com',
  ];
  List<String> colum = [
    'name',
    'email',
  ];
  MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black26,
      child: DataTable(
        columns: List.generate(
          colum.length,
          (index) => DataColumn(
            label: Text(
              colum[index],
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        rows: List.generate(
          name.length,
          (index) => DataRow(
            cells: <DataCell>[
              DataCell(Text(name[index])),
              DataCell(Text(email[index])),
            ],
          ),
        ),
      ),
    );
  }
}

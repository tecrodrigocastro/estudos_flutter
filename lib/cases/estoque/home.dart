import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  MyWidget({Key? key}) : super(key: key);

  List<String> titleCard = ['Produtos', 'Estoque', 'Retirada'];
  List<String> cardValues = ['200', '300', '100'];
  List<String> name = [
    'Sarah',
    'Janine',
    'William',
    'William',
  ];
  List<String> email = [
    'Sarah@gmail.com',
    'Janine@gmial.com',
    'William@gmail.com',
    'William@gmail.com',
  ];
  List<String> colum = [
    'Produto',
    'Qtd. retirada',
    'Qtd. em Estoque',
    'Usuario',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    double sizeW = MediaQuery.of(context).size.width;
    bool isMobile(BuildContext context) => sizeW < 800;
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Menu Principal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          color: Colors.blueGrey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                titleCard[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile(context) ? 22 : 30,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                cardValues[index],
                                style: TextStyle(
                                  fontSize: isMobile(context) ? 20 : 25,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: !isMobile(context) ? 50 : 20),
              const ListTile(
                leading: Icon(
                  Icons.shopping_cart_checkout_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                title: Text(
                  'Retiradas Recentes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(height: !isMobile(context) ? 50 : 20),
              Scrollbar(
                controller: controller,
                child: SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      child: DataTable(
                        border: TableBorder.all(width: 1),
                        columns: colum
                            .map(
                              (title) => DataColumn(
                                label: Text(
                                  title,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        rows: List.generate(
                          name.length,
                          (index) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(name[index])),
                              DataCell(Text(email[index])),
                              DataCell(Text(email[index])),
                              DataCell(Text(email[index])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:estudos/cases/estoque/cad_product.dart';
import 'package:estudos/cases/estoque/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/home');

    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage(), children: [
          ChildRoute('/home', child: (context, args) => MyWidget()),
          ChildRoute('/add_product',
              child: (context, args) => const CadProduct()),
          ChildRoute('/get_product',
              child: (context, args) => const InternalPage(
                  title: 'Listar Produto', color: Colors.amber)),
          ChildRoute('/stock',
              child: (context, args) =>
                  const InternalPage(title: 'Estoque', color: Colors.green)),
        ]),
      ];
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeW = MediaQuery.of(context).size.width;
    bool isMobile(BuildContext context) => sizeW < 800;
    final leading = SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Modular.to.navigate('/home'),
          ),
          ListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            title: const Text(
              'Cadastrar Produto',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Modular.to.navigate('/add_product'),
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            title: const Text(
              'Lista de Produto',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Modular.to.navigate('/get_product'),
          ),
          ListTile(
            leading: const Icon(
              Icons.receipt_long_sharp,
              color: Colors.white,
            ),
            title: const Text(
              'Estoque',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Modular.to.navigate('/stock'),
          ),
          const Spacer(),
          ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text(
                'Rodrigo Castro',
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ))),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: GestureDetector(
          onTap: () => Modular.to.navigate('/home'),
          child: const Text('Gerencia de produtos'),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      drawer: isMobile(context)
          ? Drawer(backgroundColor: Colors.blueGrey, child: leading)
          : null,
      body: Row(
        children: [
          if (!isMobile(context)) leading,
          Container(width: 2, color: Colors.black45),
          const Expanded(child: RouterOutlet()),
        ],
      ),
    );
  }
}

class InternalPage extends StatelessWidget {
  final String title;
  final Color color;
  const InternalPage({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: Center(child: Text(title)),
    );
  }
}

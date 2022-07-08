import 'package:flutter/material.dart';

class ResposiveCase extends StatefulWidget {
  const ResposiveCase({Key? key}) : super(key: key);

  @override
  State<ResposiveCase> createState() => _ResposiveCaseState();
}

class _ResposiveCaseState extends State<ResposiveCase> {
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Responsividade no flutter'),
            actions: [
              Text('$screenWidth'),
            ],
          ),
          //isMobile(context) ? Drawer(child: sidebar()) : null
          drawer: isMobile(context) ? Drawer(child: sidebar()) : null,
          body: Row(
            children: [
              AnimatedCrossFade(
                firstChild: Container(
                    color: Colors.white, width: 300, child: sidebar()),
                secondChild: SizedBox.shrink(),
                crossFadeState: !isMobile(context)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 600),
                reverseDuration: Duration(microseconds: 600),
              ),
              // if (!isMobile(context))
              Expanded(
                child: GridView.count(
                  crossAxisCount: isDesktop(context) ? 3 : 2,
                  children: List.generate(
                    40,
                    (index) => Card(
                      color: Colors.deepPurple,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Item $index'),
                            Text('Largura: $screenWidth'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget sidebar() {
    return ListView(
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('Rodrigo Castro'),
          accountEmail: Text('tec.rodrigocastro@gmail.com'),
          currentAccountPicture: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/5eeea355389655.59822ff824b72.gif"),
          ),
        ),
        ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Perfil"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              debugPrint('Toquei no perfil');
            }),
        ListTile(
            leading: const Icon(Icons.list),
            title: const Text("Lista de Objetos"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              debugPrint('Toquei no Lista');
            }),
      ],
    );
  }
}

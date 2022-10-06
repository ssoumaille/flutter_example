import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appTitle,
        initialRoute: '/',
        routes: <String, WidgetBuilder> {
          '/': (context) => const MyHomePage(title: appTitle),
          '/1': (context) => const Page1(),
          '/2': (context) => const Page2(),
          '/3': (context) => const Page3(),
          '/4': (context) => const Page4(),
        }

      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  final pages = [
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
  ];

  final controller = PageController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(MyApp.appTitle)),
        body: PageView(
          controller: controller,
          children: const [
            Page1(),
            Page2(),
            Page3(),
            Page4(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 129, 154, 235),
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Page 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, '/1');
                },
              ),
              ListTile(
                title: const Text('Page 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, '/2');
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () => setState(() => pages[0]),
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () => setState(() => pages[1]),
                icon: const Icon(
                  Icons.work_outline_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () => setState(() => pages[2]),
                icon: const Icon(
                  Icons.widgets_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () => setState(() => pages[3]),
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      );
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffC4DFCB),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                "Page Number 1",
                style: TextStyle(
                  color: Colors.green.shade900,
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      child: Material(
        color: const Color(0xffC4DFCB),
        child: Center(
          child: Text(
            "Page Number 2",
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 45,
              fontWeight: FontWeight.w500,
            ),
          )
        ),
      ),
  );
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: const Color(0xffC4DFCB),
        child: Center(
          child: Text(
            "Page Number 3",
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: const Color(0xffC4DFCB),
        child: Center(
          child: Text(
            "Page Number 4",
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}

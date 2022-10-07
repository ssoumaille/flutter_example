import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Flutter Demo';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appTitle,
        home: const MyHomePage(title: appTitle),
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
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
  final controller = PageController();

  int pageIndex = 0;

  final pages = const [Page1(), Page2(), Page3(), Page4(),];

  Widget _buildPageView() => PageView(
        controller: controller,
        children: const [
          Page1(),
          Page2(),
          Page3(),
          Page4(),
        ],
      );

  Widget _buildDrawer() => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 129, 154, 235),
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
            ListTile(
              title: const Text('Page 3'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, '/3');
              },
            ),
            ListTile(
              title: const Text('Page 4'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, '/4');
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(MyApp.appTitle)),
        body: pages[pageIndex],
        drawer: _buildDrawer(),
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconButton1(context),
              iconButton2(context),
              iconButton3(context),
              iconButton4(context),
            ],
          ),
        ),
      );
}

Widget iconButton1(context) => IconButton(
      enableFeedback: false,
      onPressed: () => Navigator.pushNamed(context, '/1'),
      icon: const Icon(Icons.home_outlined, color: Colors.white, size: 35),
    );

Widget iconButton2(context) => IconButton(
      enableFeedback: false,
      onPressed: () => Navigator.pushNamed(context, '/2'),
      icon: const Icon(Icons.work_outline_outlined, color: Colors.white, size: 35),
    );

Widget iconButton3(context) => IconButton(
  enableFeedback: false,
  onPressed: () => Navigator.pushNamed(context, '/3'),
  icon: const Icon(Icons.widgets_outlined, color: Colors.white, size: 35),
);

Widget iconButton4(context) => IconButton(
  enableFeedback: false,
  onPressed: () => Navigator.pushNamed(context, '/4'),
  icon: const Icon(Icons.person_outline, color: Colors.white, size: 35),
);

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  build(context) => Scaffold(
        backgroundColor: const Color(0xffC4DFCB),
        body: Center(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: Text(
              "Page Number 1",
              style: TextStyle(
                color: Colors.green.shade900,
                fontSize: 45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
          )),
        ),
      );
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
          child: Material(
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
      ));
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
          child: Material(
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
      ));
}

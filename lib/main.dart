import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_validator/string_validator.dart';

import 'person.dart';
import 'widgets_icon_button.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

final stateProvider =
    StateNotifierProvider<PersonService, Person>((ref) => PersonService());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Flutter Demo';

  @override
  Widget build(_) => MaterialApp(
          title: appTitle,
          home: const MyHomePage(title: appTitle),
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            primaryColor: Colors.black54,
          ),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/1': (context) => const Page1(),
            '/2': (context) => const Page2(),
            '/3': (context) => const Page3(),
            '/4': (context) => const Page4(),
          });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> {
  final controller = PageController();

  int pageIndex = 0;

  final pages = const [Page1(), Page2(), Page3(), Page4()];

  Widget _buildDrawer(context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text('Drawer Header'),
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
  build(context) => Scaffold(
        appBar: AppBar(title: const Text(MyApp.appTitle)),
        body: pages[pageIndex],
        drawer: _buildDrawer(context),
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
              bottomBarButton1(context),
              bottomBarButton2(context),
              bottomBarButton3(context),
              bottomBarButton4(context),
            ],
          ),
        ),
      );
}

class PersonService extends StateNotifier<Person> {
  PersonService() : super(Person(firstName: '', lastName: '', age: 33));

  void firstNamePersonUpdate(String name) =>
      state = state.copyWith(firstName: name);

  void lastNamePersonUpdate(String name) =>
      state = state.copyWith(lastName: name);

  void agePersonUpdate(int age) => state = state.copyWith(age: age);
}

class Page1 extends ConsumerWidget {
  const Page1({super.key});

  @override
  build(context, ref) => Scaffold(
        backgroundColor: const Color(0xff878484),
        body: Container(
          margin: const EdgeInsets.fromLTRB(48, 48, 48, 48),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First name',
                ),
                onChanged: (String text) => ref
                    .read(stateProvider.notifier)
                    .firstNamePersonUpdate(text),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last name',
                ),
                onChanged: (String text) =>
                    ref.read(stateProvider.notifier).lastNamePersonUpdate(text),
              ),
              TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'age',
                  ),
                  onChanged: (String text) {
                    if (isNumeric(text)) {
                      ref
                          .read(stateProvider.notifier)
                          .agePersonUpdate(int.parse(text));
                    }
                  }),
              Text(
                ref.read(stateProvider).firstName == ''
                    ? 'Name to update'
                    : ''
                        '${ref.read(stateProvider).firstName} ${ref.read(stateProvider).lastName} '
                        'is ${ref.read(stateProvider).age} years old',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
}

class Page2 extends ConsumerWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  build(_, ref) => Material(
        color: const Color(0xffFFFFFF),
        child: Center(
            child: Text(
          '${ref.read(stateProvider).firstName} '
          '${ref.read(stateProvider).lastName} '
          'is ${ref.read(stateProvider).age} years old',
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
        )),
      );
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  build(_) => Material(
        color: const Color(0xffFFFFFF),
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
  build(_) => Material(
        color: const Color(0xffFFFFFF),
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

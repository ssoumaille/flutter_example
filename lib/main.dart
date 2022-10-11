import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_example/pieces/pieces.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:string_validator/string_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'person/person.dart';
import 'widgets_icon_button.dart';
import 'firebase_options.dart';

final log = Logger('MyApp');

void main() async {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

final personProvider = StateNotifierProvider<PersonService, Person>((ref) => PersonService());

final piecesProvider = StreamProvider<List<Pieces>>((ref) => FirebaseFirestore.instance
      .collection(Collection.pieces.name).snapshots().map((event) {
        var list = event.docs.map((e)
{
  // log.info(e.data());
  int longueur = e.data()['longueur'] is int ? e.data()['longueur'] : e.data()['longueur'].round();
  int largeur = e.data()['largeur'] is int ? e.data()['largeur'] : e.data()['largeur'].round();
  int hauteur = e.data()['hauteur'] is int ? e.data()['hauteur'] : e.data()['hauteur'].round();


   var pieces = Pieces(
       longueur: longueur,
       largeur: largeur,
       hauteur: hauteur);
   return pieces;
}).toList();
        return list;
      }));

class Page3 extends ConsumerWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  build(_, ref) =>
      Material(
        color: const Color(0xffFFFFFF),
        child: Center(
          child: ref.watch(piecesProvider).when(
            data: (content) => ListView.builder(
              itemCount: content.length,
              itemExtent: 60,
              itemBuilder: (context, index) => ColoredBox(
                  color: Colors.blue,
                  child: Text(content[index].longueur.toString())),
            ),
            error: (err, stack) => const Icon(Icons.error, color: Colors.red,),
            loading: () => const LinearProgressIndicator(),
          ),
        ),
      );
}

enum Collection { pieces }

enum Routes {
  user_creation,
  user_info,
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Flutter Demo';

  @override
  Widget build(_) =>
      MaterialApp(
          title: appTitle,
          home: const MyHomePage(title: appTitle),
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            primaryColor: Colors.black45,
          ),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/${Routes.user_creation.name}': (context) => const Page1(),
            '/${Routes.user_info.name}': (context) => const Page2(),
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

  Widget _buildDrawer(context) =>
      Drawer(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              child: const Text('Header'),
            ),
            ListTile(
              title: const Text('Implement a User'),
              onTap: () =>
                  Navigator.pushNamed(context, '/${Routes.user_creation.name}'),
            ),
            ListTile(
              title: const Text('User information'),
              onTap: () =>
                  Navigator.pushNamed(context, '/${Routes.user_info.name}'),
            ),
            ListTile(
              title: const Text('Page 3'),
              onTap: () => Navigator.pushNamed(context, '/3'),
            ),
            ListTile(
              title: const Text('Page 4'),
              onTap: () => Navigator.pushNamed(context, '/4'),
            ),
          ],
        ),
      );

  @override
  build(context) =>
      Scaffold(
        appBar: AppBar(title: const Text(MyApp.appTitle)),
        body: pages[pageIndex],
        drawer: _buildDrawer(context),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor,
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
  build(context, ref) =>
      Scaffold(
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
                onChanged: (String text) =>
                    ref
                        .read(personProvider.notifier)
                        .firstNamePersonUpdate(text),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last name',
                ),
                onChanged: (String text) =>
                    ref.read(personProvider.notifier).lastNamePersonUpdate(text),
              ),
              TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'age',
                  ),
                  onChanged: (String text) {
                    if (isNumeric(text)) {
                      ref
                          .read(personProvider.notifier)
                          .agePersonUpdate(int.parse(text));
                    }
                  }),
              Text(
                ref
                    .read(personProvider)
                    .firstName == ''
                    ? 'Name to update'
                    : '${ref
                    .read(personProvider)
                    .firstName} '
                    '${ref
                    .read(personProvider)
                    .lastName} '
                    'is ${ref
                    .read(personProvider)
                    .age} years old',
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
  build(_, ref) =>
      Material(
        color: const Color(0xffFFFFFF),
        child: Center(
            child: Text(
              '${ref
                  .read(personProvider)
                  .firstName} '
                  '${ref
                  .read(personProvider)
                  .lastName} '
                  'is ${ref
                  .read(personProvider)
                  .age} years old',
              style: TextStyle(
                color: Colors.green[900],
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            )),
      );
}



class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  build(_) =>
      Material(
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

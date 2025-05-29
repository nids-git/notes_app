import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/notes_list_ui.dart';
import 'package:flutter_app/utils/controller/DataController.dart';
import 'package:flutter_app/utils/controller/NoteController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../commonui/CommonDropDown.dart';
import '../commonui/commonRadioButton.dart';
import '../utils/model/NotesModel.dart';
import '../utils/model/postModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');

  runApp( ChangeNotifierProvider(create:(_) => NoteController(),
  child: MyApp(),)
  );
}
// C:\Users\lenovo\Downloads\jdk-17.0.12_windows-x64_bin\jdk-17.0.12\bin\keytool.exe keytool -list -v -alias androiddebugkey -keystore C:\Users\lenovo\.android\debug.keystore

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: NotesListUI(),
      //const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final DataController dataController = Get.put(DataController());
  final PostModel listData =
    PostModel(
      tab1: "Yes", tab2:"No",
      item1: ["Car", "Scooter","Bicycle"],
      item2: ["Cow","Dog","Rat","Buffalo"]
    );

  // final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  // final List<String> items1 = ['Option 5', 'Option 6', 'Option 7', 'Option 8'];
  // final List<String> items2 = ['Option 9', 'Option 10', 'Option 11', 'Option 12'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body:
        SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back),
                      Text('My Title',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Skip', style: TextStyle(fontSize: 14))
                    ],
                  ),
                ),
                TabBar(
                  indicator: BoxDecoration(
                    color: Colors.transparent,
                  ),
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    tabs: [Tab(text: listData.tab1.toString()), Tab(text: listData.tab2.toString())]),
              Expanded(
                  child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              DropdownExample(items: listData.item1,),
                              SizedBox(
                                height: 2,
                              ),
                              Column(
                                children: [
                                  DropdownExample(items: listData.item2,)
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Column(
                                children: [
                                  DropdownExample(items: listData.item1,)
                                ],
                              )
                            ],
                          ),
                        ),

                        SingleChildScrollView(
                          child: Column(
                            children: [
                              RadioExample(),
                              SizedBox(
                                height: 2,
                              ),
                              DropdownExample(items: listData.item1,),
                              SizedBox(
                                height: 2,
                              ),
                              DropdownExample(items: listData.item2,),
                              SizedBox(
                                height: 2,
                              ),
                              DropdownExample(items: listData.item1,)
                            ],
                          ),
                        )
                      ]
                  )
              )

              /*  SizedBox(
                  height: 20,
                ),
                DropdownExample(),
                RadioExample()*/
              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}




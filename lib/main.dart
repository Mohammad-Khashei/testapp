import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'Home.dart';
import 'p_json.dart';
import 'picture.dart';
import 'profile.dart';
import 'search.dart';
import 'video.dart';
import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
//import 'package:shimmer/shimmer.dart';

void main()  {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, statusBarColor: Colors.black));
  runApp(const MyApp());
}
//class FakeRepository {
//  Future<List<>>
//}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        duration: 3000,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.blue,
        splash: Center(
          child: Container(
            child: const Text(
              'Test Apps',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        nextScreen: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int currentindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fatchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                'Test',
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
            child: ListView(
          children: [
            const DrawerHeader(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: UserAccountsDrawerHeader(
                accountName: Text("Mohammad Khashei"),
                accountEmail: Text("mookashei2@yahoo.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.black26,
                  child: Text(
                    "M",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
            const ListTile(
              title: Text('Item 1'),
              onTap: null,
            ),
            const ListTile(
              title: Text('Item 2'),
              onTap: null,
            ),
            const ListTile(
              title: Text('Item 3'),
              onTap: null,
            ),
            ListTile(
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationIcon: FlutterLogo(),
                    applicationVersion: "1.0",
                    applicationLegalese: "Legalese information ...",
                    applicationName: "Flutter Test App");
              },
              title: const Text(
                'More information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          unselectedItemColor: Colors.black26,
          fixedColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Picture',
              icon: Icon(Icons.photo_camera_sharp),
            ),
            BottomNavigationBarItem(
              label: 'Video',
              icon: Icon(Icons.videocam),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(Icons.search_sharp),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.account_circle),
            ),
          ],
          onTap: (int indexOfItem) {
            setState(() {
              currentindex = indexOfItem;
            });
          },
        ),
        body: setPage());
  }

  Widget setPage() {
    final deviceOrientation = MediaQuery.of(context).orientation;
    switch (currentindex) {
      case 0:
        return buildHome();
      //   break;
      case 1:
        return deviceOrientation == Orientation.portrait
            ? buildPicture(context)
            : buildPicturel(context);
      //   break;
      case 2:
        return buildVideo();
      //   break;
      case 3:
        return buildSearch();
      //   break;
      case 4:
        return buildProfile();
      //   break;
      default:
        return buildHome();
    }
  }

  void fatchItems() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var response = await http.get(url);
    setState(() {
      var pictuerJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in pictuerJson) {
        var picItem = Pjson(i['title'], i['url']);
        items.add(picItem);
      }
    });
  }
}

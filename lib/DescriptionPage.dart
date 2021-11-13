// ignore_for_file: file_names
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'p_json.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
}
class DesPage extends StatefulWidget {
  final Pjson _pjson;

  const DesPage(this._pjson, {Key? key}) : super(key: key);

  @override
  State<DesPage> createState() => _DesPageState();
}

class _DesPageState extends State<DesPage> {
/*  bool loading = false;

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          print(directory.path);
          String newPath = "";
          //    /storage/emulated/0/Android/data/com.example.myapp/files/
          List<String> folders = directory.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/RPSapp";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {

      }
    } catch (e) {

    }
    return false;
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile() async {
    setState(() {
      loading = true;
    });

    bool downloaded =
        await saveFile("https://www.google.com/images/branding/googlelogo/1x/googlelogo_light_color_272x92dp.png", "picture.png");
    if (downloaded) {
      print("File DownLoaded");
    } else {
      print("problem");
    }
    setState(() {
      loading = false;
    });
  }*/
  downloadFile() async {
    final status = await Permission.storage.request();

    if(status.isGranted){
      final baseStorage = await getExternalStorageDirectory();

      final id = await FlutterDownloader.enqueue(url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', savedDir: baseStorage.path,fileName:'fileName');
    } else {
      print('no permission');
    }
  }
  int progress = 0 ;
  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {

    IsolateNameServer.registerPortWithName(receivePort.sendPort, "Downloading Picture");

    receivePort.listen((message) {
      receivePort.listen((message) {
        setState(() {
          progress = message;
        });
      });

    });
    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  static downloadCallback(id,status,progress){
    SendPort sendPort =IsolateNameServer.lookupPortByName("Downloading Picture");
    sendPort.send(progress);
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
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget._pjson.url,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          Flexible(
              fit: FlexFit.tight,
              child: AutoSizeText(
                widget._pjson.title,
                textDirection: TextDirection.ltr,
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.justify,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        primary: Colors.pink, backgroundColor: Colors.blue),
                    icon: const Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                    ),
                    onPressed: downloadFile,
                    label: const Text(
                      "Download Picture",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Text('$progress')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

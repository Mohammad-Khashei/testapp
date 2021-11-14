// ignore_for_file: file_names
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'p_json.dart';
import 'package:permission_handler/permission_handler.dart';


class DesPage extends StatefulWidget {
  final Pjson _pjson;

  const DesPage(this._pjson, {Key? key}) : super(key: key);

  @override
  State<DesPage> createState() => _DesPageState();
}

class _DesPageState extends State<DesPage> {

  _save() async {
    var status = await Permission.storage.request();
    if(status.isGranted) {
      var response = await Dio().get(
          widget._pjson.url,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      print(result);
    }
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
                  applicationIcon: const FlutterLogo(),
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
                    onPressed: _save,
                    label: const Text(
                      "Download Picture",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

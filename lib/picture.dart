import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'p_json.dart';
import 'dart:ui';
import 'DescriptionPage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<Pjson> items = [];

class picst extends StatelessWidget {
  Pjson pjson;

  picst(this.pjson, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget buildPicture(context) =>

    StaggeredGridView.extentBuilder(
      itemCount: items.length - 200,
      staggeredTileBuilder: (index) => const StaggeredTile.extent(1, 300),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      maxCrossAxisExtent: 400,
      itemBuilder: (context, position) =>
          generateItem(items[position], context),


);

Widget buildPicturel(context) => StaggeredGridView.countBuilder(
      itemCount: items.length,
      staggeredTileBuilder: (context) => const StaggeredTile.count(1, 1),
      crossAxisCount: 4,
      itemBuilder: (context, position) =>
          generateItem(items[position], context),
    );

Widget generateItem(Pjson picture, context) {
  return Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DesPage(picture)));
      },
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  picture.url,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: Text('Loading...'),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Some errors occurred!'),
                ),
              ),
            ),
          ),
          AutoSizeText(
            picture.title,
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontSize: 20),
            minFontSize: 18,
            maxLines: 3,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

//return GridView.count(
//     padding: const EdgeInsets.all(10),
//     crossAxisCount: 1,
//     mainAxisSpacing: 10,
//     crossAxisSpacing: 5,
//     // childAspectRatio: (200 / 400), custom size
//     children: List.generate(items.length, (int position){
//       return generateItem(items[position],context);
//     }),
//   );

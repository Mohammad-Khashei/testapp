import 'package:flutter/material.dart';



class CardItem {
  late String urlImage;
  late String title;


  CardItem({
    required this.urlImage,
    required this.title,
  });
}
  List<CardItem> itemcardItem = [
    CardItem(
      urlImage: 'https://via.placeholder.com/600/92c952',
      title: 'Test 1',
    ),
    CardItem(
      urlImage: 'https://via.placeholder.com/600/771796',
      title: 'Test 2',
    ),
    CardItem(
      urlImage: 'https://via.placeholder.com/600/f66b9',
      title: 'Test 3',
    ),
    CardItem(
      urlImage: 'https://via.placeholder.com/600/51aa97',
      title: 'Test 4',
    ),
    CardItem(
      urlImage: 'https://via.placeholder.com/600/810b14',
      title: 'Test 5',
    ),
  ];


  Widget buildHome() {
    return Scaffold(
        body: SizedBox(
          height: 200,
          child: ListView.separated(
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.horizontal,
            itemCount: itemcardItem.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) =>
                buildCard(itemcardItem[index], context),
          ),
        ),


    );
  }

  Widget buildCard(CardItem item, context) =>
      Container(
        width: 200,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: Ink.image(
                      image: NetworkImage(item.urlImage),
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () { },
                      ),
                    ),
                  )),
            ),
            const SizedBox(height: 4),
            Text(
              item.title,
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      );

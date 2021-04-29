import 'package:yalla_activities/Screen/B1_Home/Home_Search/search_page.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Hiking/hiking.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Bicycling/Bicycling.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Art/Art.dart';
import 'package:flutter/material.dart';

import 'Category_types/Yoga/Yoga.dart';
import 'Category_types/Camping/Camping.dart';
import 'Category_types/Music/music.dart';
import 'Category_types/Gym/gym.dart';
import 'Category_types/Swimming/swimming.dart';

class Category extends StatefulWidget {
  String userId;
  Category({this.userId});

  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    /// Component appbar
    var _appbar = AppBar(
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text(
          "Category",
          style: TextStyle(
              fontFamily: "Gotik",
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new SearchPage(
                      idUser: widget.userId,
                    )));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Icon(
              Icons.search,
              size: 27.0,
              color: Colors.black54,
            ),
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,

      /// Calling variable appbar
      appBar: _appbar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new hiking(
                            userId: widget.userId,
                            nameAppbar: "Hiking",
                          )));
                },
                child: itemCard(
                    image: "assets/image/category_activity/hiking.png",
                    title: "Hiking")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Yoga(
                            userId: widget.userId,
                          )));
                },
                child: itemCard(
                  image: "assets/image/category_activity/yoga.png",
                  title: "Yoga",
                )),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Camping(
                            userId: widget.userId,
                          )));
                },
                child: itemCard(
                  image: "assets/image/category_activity/camping.jpg",
                  title: "Camping",
                )),
            //   itemCard(image: "assets/image/category_country/country5.png",title: "Paris",),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Bicycling(
                            userId: widget.userId,
                          )));
                },
                child: itemCard(
                  image: "assets/image/category_activity/Bicycling.png",
                  title: "Bicycling",
                )),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new swimming(
                            userId: widget.userId,
                          )));
                },
                child: itemCard(
                  image: "assets/image/category_activity/Swimming.jpg",
                  title: "Swimming",
                )),
                InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new art(
                            userId: widget.userId,
                          )));
                },
                child: itemCard(
                  image: "assets/image/category_activity/art.jpg",
                  title: "Art & Culture",
                )),
                InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new music(
                            userId: widget.userId,
                          )));
                },
                child: itemCard(
                  image: "assets/image/category_activity/music.jpg",
                  title: "Music",
                )),
                InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new gym(
                            userId: widget.userId,
                          )));
                },
                child: itemCard(
                  image: "assets/image/category_activity/gym.jpg",
                  title: "Gym",
                )),
          ],
        ),
      ),
    );
  }
}

///
/// Create item card
///
class itemCard extends StatelessWidget {
  String image, title;
  itemCard({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Container(
        height: 140.0,
        width: 400.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFABABAB).withOpacity(0.7),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.black12.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 39.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:yalla_activities/Screen/B2_Category/Category_types/Hiking/hiking.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Bicycling/Bicycling.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Music/music.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Swimming/swimming.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Gym/gym.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Camping/camping.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Yoga/yoga.dart';
import 'package:yalla_activities/Screen/B2_Category/Category_types/Art/Art.dart';
import 'package:flutter/material.dart';

//search page
class searchBoxEmpty extends StatefulWidget {
  String idUser;

  searchBoxEmpty({Key key, this.idUser}) : super(key: key);

  _searchBoxEmptyState createState() => _searchBoxEmptyState();
}

class _searchBoxEmptyState extends State<searchBoxEmpty>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text("Yalla!Activities",
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontSize: 18.0,
                  letterSpacing: 0.9,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
          ),
          child: Container(
            height: 100.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new art(
                              userId: widget.idUser,
                            )));
                  },
                  child: AdvancedSearch(
                    colorTop: Color(0xFFF07DA4),
                    colorBottom: Color(0xFFF5AE87),
                    title: "Art & Culture",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new hiking(
                              userId: widget.idUser,
                              nameAppbar: "Hiking",
                            )));
                  },
                  child: AdvancedSearch(
                      colorTop: Color(0xFF63CCD1),
                      colorBottom: Color(0xFF75E3AC),
                      title: "Hiking"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new swimming(
                              userId: widget.idUser,
                              
                            )));
                  },
                  child: AdvancedSearch(
                      colorTop: Color(0xFF9183FC),
                      colorBottom: Color(0xFFDB8EF6),
                      title: "Swimming"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Bicycling(
                              userId: widget.idUser,
                            )));
                  },
                  child: AdvancedSearch(
                      colorTop: Color(0xFF56B4EE),
                      colorBottom: Color(0xFF59CCE1),
                      title: "Bicycling"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Camping(
                              userId: widget.idUser,
                            )));
                  },
                  child: AdvancedSearch(
                      colorTop: Color(0xFF56B4EE),
                      colorBottom: Color(0xFF59CCE1),
                      title: "Camping"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new gym(
                              userId: widget.idUser,
                            )));
                  },
                  child: AdvancedSearch(
                      colorTop: Color(0xFF56B4EE),
                      colorBottom: Color(0xFF59CCE1),
                      title: "Gym"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new music(
                              userId: widget.idUser,
                            )));
                  },
                  child: AdvancedSearch(
                      colorTop: Color(0xFF56B4EE),
                      colorBottom: Color(0xFF59CCE1),
                      title: "Music"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Yoga(
                              userId: widget.idUser,
                            )));
                  },
                  child: AdvancedSearch(
                      colorTop: Color(0xFFF07DA4),
                      colorBottom: Color(0xFFF5AE87),
                      title: "Yoga"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AdvancedSearch extends StatelessWidget {
  Color colorTop, colorBottom;
  String title;
  AdvancedSearch({this.colorTop, this.colorBottom, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
      child: Container(
        height: 200.0,
        width: 130.0,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
              colors: [colorTop, colorBottom],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Sofia", fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

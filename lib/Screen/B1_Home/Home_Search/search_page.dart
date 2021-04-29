import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:yalla_activities/Library/loader_animation/dot.dart';
import 'package:yalla_activities/Library/loader_animation/loader.dart';
import 'package:yalla_activities/Screen/B1_Home/Home_Search/searchBoxEmpty.dart';
import 'package:flutter/material.dart';
import 'package:yalla_activities/widget/advanced_search_item_widget.dart';

import '../Detail_Event.dart';

class SearchPage extends StatefulWidget {
  final String idUser;

  SearchPage({this.idUser});

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _addNameController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  SfRangeValues _values = SfRangeValues(40.0, 80.0);
  String searchString;
  String category;
  String place;
  String price;
  Stream<QuerySnapshot> stream;

  // Future getCategory() async {
  //   var ref = firestore.collection('event');
  //   QuerySnapshot eventsQuery = await ref.where("category").get();
  //   // return eventsQuery.docs.forEach((document)=> document.data()['category']);
  //
  //   return eventsQuery.docs.forEach((document) {
  //     return document.data()['category'];
  //   });
  // }

  // getDeals() {
  // firestore
  //     .collection("event")
  //     .where('category', isEqualTo: 'Art')
  //     .where('price', isEqualTo: '200')
  //     .where('country', isEqualTo: 'Saudi Arabia')
  //     .get().then((querySnapshot) {
  //       print(querySnapshot.docs.toList());
  //   querySnapshot.docs.forEach((doc) async {
  //     print(doc.id + " => " + doc.exists.toString());
  //     print(doc.id + " => " + doc.data()['title']);
  //     // var d = await getCategory();
  //     // print('categories' + " =>  ${d.toString()} ");
  //   });
  // }).catchError((error) {
  //   print("Error getting documents: " + error.toString());
  // });
  // }

  @override
  void initState() {
    super.initState();
    _addNameController = TextEditingController();
  }

  _filterDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: filterWidget(context),
          );
        });
  }

   filterWidget(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 0.2,
                    blurRadius: 0.5)
              ]),
          padding: EdgeInsets.all(10),
          // color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                child: Text('Search Filter',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),

              ///categories
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),
              categoriesSection(),

              ///location
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Location',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),
              locationSection(),

              ///price
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Price',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),
              priceSection(),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('apply button => $category + $place');
                      setState(() {
                        stream = FirebaseFirestore.instance
                            .collection("event")
                        .where('category', isEqualTo: category)
                            .where('place', isEqualTo: place)
                            .where("searchIndex", arrayContains: searchString)
                            // .where('price', arrayContains: [_values.start,_values.end])
                            .snapshots();

                        Navigator.pop(context);
                      });
                    },
                    child: Text("Apply", style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(getColor)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('reset category & place ' );
                      category = null;
                      place = null;
                      setState(() {
                        stream = FirebaseFirestore.instance
                            .collection("event")
                            .where('category', isEqualTo: category)
                            .where('place', isEqualTo: place)
                            .where("searchIndex", arrayContains: searchString)
                        // .where('price', arrayContains: [_values.start,_values.end])
                            .snapshots();
                      });
                        Navigator.pop(context);
                      },
                    child: Text("Reset", style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(getColor)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Color(0xFF1BC0C5);
  }

  StreamBuilder<DocumentSnapshot> priceSection() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('AppSettings')
            .doc('priceRange')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          print(snapshot.data['low']);
          return Container(
            // height: 60.0,
            // height: 100.0,
            child: SfRangeSlider(
              min: snapshot.data['low'].toDouble(),
              max: snapshot.data['high'].toDouble(),
              values: _values,
              interval: snapshot.data['interval'].toDouble(),
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              onChanged: (SfRangeValues values) {
                setState(() {
                  _values = values;
                });
                print("${_values.start} ' = '  ${_values.end}");
              },
            ),
          );
        });
  }

  StreamBuilder<QuerySnapshot> locationSection() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("places").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            height: 60.0,
            // height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return TextButton(
                  onPressed: () {
                    place = snapshot.data.docs[index]['placeName'];
                    print(place);
                  },
                  child: AdvancedSearchItem(
                    colorTop: Colors.white,
                    colorBottom: Colors.white38,
                    textColor: Colors.black38,
                    title: snapshot.data.docs[index]['placeName'],
                  ),
                );
              },
            ),
          );
        });
  }

  StreamBuilder<QuerySnapshot> categoriesSection() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("categories").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            height: 100.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return TextButton(
                  onPressed: () {
                    category = snapshot.data.docs[index]['title'];
                    print(category.toString());
                  },
                  child: AdvancedSearchItem(
                    colorTop: Color(HexColor.getColorFromHex(
                        snapshot.data.docs[index]['colorTop'])),
                    colorBottom: Color(HexColor.getColorFromHex(
                        snapshot.data.docs[index]['colorBottom'])),
                    title: snapshot.data.docs[index]['title'],
                  ),
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurpleAccent,
        ),
        title: Text(
          "Search",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19.0,
              color: Colors.black54,
              fontFamily: "Sofia"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 25.0, left: 20.0, right: 50.0),
              child: Text(
                "What would you like to search ?",
                style: TextStyle(
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w600,
                    fontSize: 27.0,
                    color: Colors.black54,
                    fontFamily: "Sofia"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 25.0, right: 20.0, left: 20.0, bottom: 20.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15.0,
                          spreadRadius: 0.0)
                    ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 10.0,
                    ),
                    child: Theme(
                      data: ThemeData(hintColor: Colors.transparent),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchString = value.toLowerCase();
                            stream = FirebaseFirestore.instance
                                .collection("event")
                                .where("searchIndex",
                                    arrayContains: searchString)
                                .snapshots();
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.8)),
                          prefixIcon: Icon(Icons.search,
                              size: 20, color: Theme.of(context).hintColor),
                          suffixIcon: IconButton(
                            onPressed: () => _filterDialog(),
                            icon: Icon(Icons.widgets_outlined,
                                size: 20,
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.5)),
                          ),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // todo
            StreamBuilder<QuerySnapshot>(
              stream: (searchString == null || searchString.trim() == "")
                  ? FirebaseFirestore.instance.collection("event").snapshots()
                  :stream,
              builder: (context, snapshot) {
                print(snapshot.data.docs.length);
                if (snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                }
                if (searchString == null){
                  return searchBoxEmpty(
                    idUser: widget.idUser,
                  );
                }
                if (searchString.trim() == ""){
                  return searchBoxEmpty(
                    idUser: widget.idUser,
                  );
                }
                if (snapshot.data.docs.isEmpty){
                  return noItem();
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Padding(
                      padding: const EdgeInsets.only(top: 110.0),
                      child: Center(
                          child: ColorLoader5(
                        dotOneColor: Colors.red,
                        dotTwoColor: Colors.blueAccent,
                        dotThreeColor: Colors.green,
                        dotType: DotType.circle,
                        dotIcon: Icon(Icons.adjust),
                        duration: Duration(seconds: 1),
                      )),
                    );
                  default:
                    return new Column(
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 15.0, bottom: 5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      new newsHeaderListDetail(
                                        category: document['category'],
                                        desc: document['desc1'],
                                        desc2: document['desc2'],
                                        desc3: document['desc3'],
                                        price: document['price'],
                                        imageUrl: document['imageUrl'],
                                        time: document['time'],
                                        date: document['date'],
                                        place: document['place'],
                                        title: document['title'],
                                        id: document['id'],
                                        host_name: document['host_name'],
                                        type: document['type'],
                                        userId: widget.idUser,
                                      ),
                                  transitionDuration:
                                      Duration(milliseconds: 600),
                                  transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                                    return Opacity(
                                      opacity: animation.value,
                                      child: child,
                                    );
                                  }),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0)
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Hero(
                                  tag: 'hero-tag-${document['id']}',
                                  child: Material(
                                    child: Container(
                                      height: 180.0,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                document['imageUrl']),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 174.0,
                                        child: Text(
                                          document['title'],
                                          style: TextStyle(
                                            fontFamily: "Sofia",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 16.0,
                                            color: Colors.black38,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Text(
                                              document['place'],
                                              style: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 16.0,
                                            color: Colors.black38,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Text(
                                              document['date'],
                                              style: TextStyle(
                                                fontFamily: "Sofia",
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 16.0,
                                            color: Colors.black38,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            document['price'],
                                            style: TextStyle(
                                              fontFamily: "Sofia",
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

///
///
/// If no item cart this class showing
///
class noItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 30.0)),
            Image.asset(
              "assets/image/searching.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              "No Matching Views ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.5,
                  color: Colors.black26.withOpacity(0.3),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}

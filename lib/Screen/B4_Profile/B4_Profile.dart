import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yalla_activities/Screen/B4_Profile/updateProfile.dart';
import 'package:yalla_activities/Screen/Login/ChoseLoginOrSignup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_activities/admin/add_event.dart';
import 'B4_About_Apps.dart';
import 'B4_Call_Center.dart';

class profile extends StatefulWidget {
  String uid;

  profile({this.uid});

  @override
  _profileState createState() => _profileState();
}

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

/// Get _txt and custom value of Variable for Name User
var _txtName = _txt.copyWith(fontWeight: FontWeight.w700, fontSize: 17.0);

/// Get _txt and custom value of Variable for Edit text
var _txtEdit = _txt.copyWith(color: Colors.black26, fontSize: 15.0);

/// Get _txt and custom value of Variable for Category Text
var _txtCategory = _txt.copyWith(
    fontSize: 14.5, color: Colors.black54, fontWeight: FontWeight.w500);

class _profileState extends State<profile> {
  File selectedImage;
  String filename;
  bool isLoading = false;

  SharedPreferences prefs;
  String email, nama, country, photoProfile, city;

  ///
  /// Function for if user logout all preferences can be deleted
  ///
  _delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    /// To Sett PhotoProfile,Name and Edit Profile
    var _profile = Padding(
      padding: const EdgeInsets.only(top: 75.0, left: 0.0, right: 20.0),
      child: Stack(
        children: <Widget>[
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Stack(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: Colors.black26)
                                        ])),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, left: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Loading Name",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Sofia",
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Loading Email",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Sofia",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ]);
                }
                var userDocument = snapshot.data;
                return Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          image: DecorationImage(
                                              image: NetworkImage(userDocument[
                                                          "photoProfile"] !=
                                                      null
                                                  ? userDocument["photoProfile"]
                                                  : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 7.0,
                                                color: Colors.black26)
                                          ])),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    userDocument["name"] != null
                                        ? userDocument["name"]
                                        : "Name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Sofia",
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      //jurusan!= null? jurusan :
                                      userDocument["email"] != null
                                          ? userDocument["email"]
                                          : "Email",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Sofia",
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('AppSettings')
                                .doc('admin')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              if (snapshot.data['email'] ==
                                  userDocument["email"]) {
                                return IconButton(
                                    icon: Icon(Icons.add_circle_outlined,
                                        size: 30, color: Colors.white),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  new AddEvent()));
                                    });
                              }
                              return Container();
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 205.0),
                    child: CategoryItem(
                      txt: "Edit Profile",
                      padding: 30.0,
                      image: "assets/icon/editProfile.png",
                      tap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new updateProfile(
                                  country: userDocument["country"],
                                  city: userDocument["city"],
                                  name: userDocument["name"],
                                  photoProfile: userDocument["photoProfile"] !=
                                          null
                                      ? userDocument["photoProfile"]
                                      : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
                                  uid: widget.uid,
                                )));
                      },
                    ),
                  ),
                ]);
              }),
        ],
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                /// Setting Header Banner
                Container(
                  height: 260.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/image/userpage1.jpg"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Column(
                      /// Setting Category List
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0, left: 85.0, right: 30.0, bottom: 10.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 65.0, left: 85.0, right: 30.0, bottom: 10.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                        CategoryItem(
                          txt: "Call Center",
                          padding: 30.0,
                          image: "assets/icon/callcenter.png",
                          tap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new callCenter()));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 85.0, right: 30.0, bottom: 10.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                        CategoryItem(
                          padding: 38.0,
                          txt: "About Apps",
                          image: "assets/icon/aboutapp.png",
                          tap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new aboutApps()));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 85.0, right: 30.0, bottom: 10.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                        CategoryItem(
                          txt: "Logout",
                          padding: 30.0,
                          image: "assets/icon/logout.png",
                          tap: () {
                            _delete();
                            FirebaseAuth.instance.signOut().then((result) =>
                                Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                        pageBuilder: (_, ___, ____) =>
                                            new ChoseLogin())));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 85.0, right: 30.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      ],
                    ),
                  ),
                ),

                /// Calling _profile variable
                _profile,
              ],
            ),
          ),
        ));
  }
}

/// Component category class to set list
class CategoryItem extends StatelessWidget {
  @override
  final String txt, image;
  final GestureTapCallback tap;
  final double padding;

  CategoryItem({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: Image.asset(
                    image,
                    height: 25.0,
                  ),
                ),
                Text(
                  txt,
                  style: _txtCategory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

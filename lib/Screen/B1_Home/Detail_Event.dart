import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:yalla_activities/Screen/B1_Home/Home.dart';
import 'package:yalla_activities/Screen/B3_Manage_Event/Manage_Event_Detail.dart';
import 'package:yalla_activities/constant.dart';
import 'package:yalla_activities/service/firestore_join_event.dart';
import 'package:yalla_activities/model/join_event_model.dart';
import 'package:yalla_activities/Screen/pay_screen.dart';

class newsHeaderListDetail extends StatefulWidget {
    String title,
      userId,
      category,
      imageUrl,
      desc,
      price,
      time,
      date,
      place,
      id,
      desc2,
      desc3,
      host_name,
      type;
  final index;

  newsHeaderListDetail(
      {this.id,
      this.category,
      this.desc,
      this.price,
      this.imageUrl,
      this.index,
      this.time,
      this.date,
      this.place,
      this.title,
      this.userId,
      this.desc2,
      this.host_name,
      this.type,
      this.desc3});

  _newsListDetailState createState() => _newsListDetailState();
}

class _newsListDetailState extends State<newsHeaderListDetail> {
  String _nama, _npm, _photoProfile;
  String _join = "Join & pay";
  FirebaseFirestore _firebaseFirestore=     FirebaseFirestore.instance;
  FireStoreJoinEvent _fireStoreJoinEvent=FireStoreJoinEvent();

  void _getData() {
    // StreamBuilder(
    //   stream:   _firebaseFirestore
    //       .collection('users')
    //       .doc(widget.userId)
    //       .snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return new Text("Loading");
    //     } else {
    //       var userDocument = snapshot.data;
          _nama = currentUserModel.name;
          _npm = currentUserModel.uid;
          _photoProfile = currentUserModel.photoProfile;

          //setState(() {
//            var userDocument = snapshot.data;
  //          _nama = userDocument["name"];
    //        _npm = userDocument["npm"];
      //      _photoProfile = userDocument["photoProfile"];
        //  });
        //}


        //var userDocument = snapshot.data;
        // return Stack(
        //   children: <Widget>[Text(currentUserModel.name),],
        // );
      
    
  }

  _checkFirst() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString(widget.title) == null) {
      setState(() {
        _join = "Join & pay";
      });
    } else {
      setState(() {
        _join = "Joined";
      });
    }
  }

  _check() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setString(widget.title, "1");
  }

  @override
  void initState() {
   _checkFirst();
  _getData();
   _nama=currentUserModel.name;
    _npm=widget.userId;
     _photoProfile=currentUserModel.photoProfile;
    // TODO: implement initState
    super.initState();
  }

   _onBackPressed(){
 Navigator.pop(context);
                       Navigator.push(
            context, MaterialPageRoute(builder: (context) => new 
         showCaseHome(
          userId:widget.id,
        )
            ));
 }
    void addData() {
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        FirebaseFirestore.instance
            .collection("JoinEvent")
            .doc("user")
            .collection(widget.title)
            .doc(widget.userId)
            .set({
          "nama": _nama,
          "npm": widget.userId,
          "photoProfile": _photoProfile
        });
      });
    }

    void userSaved() {
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        SharedPreferences prefs;
        prefs = await SharedPreferences.getInstance();
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userId)
            .collection('Join Event')
            .add({
          "user": widget.userId,
          "title": widget.title,
          "category": widget.category,
          "imageUrl": widget.imageUrl,
          "desc1": widget.desc,
          "desc2": widget.desc2,
          "desc3": widget.desc3,
          "price": widget.price,
          "time": widget.time,
          "date": widget.date,
          "id": widget.id,
          "place": widget.place,
          "host_name": widget.host_name,
          "type": widget.type
        });
      });
      Navigator.push(
            context, MaterialPageRoute(builder: (context) => new 
PayScreen()
            ));

    }
    List <JoinEventModel> joinEventData=[];
    
    getJoinEvent()async{
   var tmp =await _fireStoreJoinEvent.getJoinEvent(widget.title);
   setState(() {
     joinEventData=tmp;
   });


      

    }
 @override
  Widget build(BuildContext context) {
     double _height = MediaQuery.of(context).size.height;

    return  WillPopScope(
        onWillPop: () async{_onBackPressed();},
      child: Scaffold(
        
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
             CustomScrollView(
               scrollDirection: Axis.vertical,
               slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(
                        expandedHeight: MediaQuery.of(context).size.height*0.1,
                        img: widget.imageUrl,
                        title: widget.title,
                        id: widget.id),
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        // StreamBuilder(
                        //   stream: FirebaseFirestore.instance
                        //       .collection('users')
                        //       .doc(widget.userId)
                        //       .snapshots(),
                        //   builder: (context, snapshot) {
                        //     if (!snapshot.hasData) {
                        //       return new Text("Loading");
                        //     } else {
                        //       var userDocument = snapshot.data;
                        //       _nama = userDocument["name"];
                        //       _photoProfile = userDocument["photoProfile"];
                        //     }

                        //     //var userDocument = snapshot.data;

                        //    return Container();
                        //   },
                        // ),
                        joinEventData.length==0? new Text("Loading"):joinEvent(list:joinEventData,),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0, left: 20.0),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                fontFamily: "Popins"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.black26,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.date,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontFamily: "Popins"),
                                    ),
                                    Text(
                                      widget.time,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 25.0, right: 30.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.place,
                                color: Colors.black26,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Location",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontFamily: "Popins"),
                                    ),
                                    Text(
                                      widget.place,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 25.0, right: 30.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.contact_page,
                                color: Colors.black26,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "The Host",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontFamily: "Popins"),
                                    ),
                                    Text(
                                      widget.host_name,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 25.0, right: 30.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.payment,
                                color: Colors.black26,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  widget.price,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: "Popins"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 25.0, right: 30.0),
                          child: Divider(
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ),
                       
                             
                            //  StreamBuilder(
                            //   stream: FirebaseFirestore.instance
                            //       .collection("JoinEvent")
                            //       .doc("user")
                            //       .collection(widget.title)
                            //       .snapshots(),
                            //   builder: (BuildContext ctx,
                            //       AsyncSnapshot<QuerySnapshot> snapshot) {
                            //     if (!snapshot.hasData) {
                            //       return CircularProgressIndicator();
                            //     } else {
                            //       return  Container();
                            //       //joinEvent(list: snapshot.data.docs);
                            //     }
                            //   },
                            
                            // )
                       
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 20.0,
                          width: double.infinity,
                          color: Colors.black12.withOpacity(0.04),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0, left: 20.0),
                          child: Text(
                            "About",
                            style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontFamily: "Popins"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                          child: Text(
                            widget.desc,
                            style: TextStyle(
                                fontFamily: "Popins",
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                          child: Text(
                            widget.desc2,
                            style: TextStyle(
                                fontFamily: "Popins",
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                          child: Text(
                            widget.desc3,
                            style: TextStyle(
                                fontFamily: "Popins",
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 100.0,
                        )
                      ])),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70.0,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          widget.price,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 19.0,
                              fontFamily: "Popins"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: () async {

                            SharedPreferences prefs;
                            prefs = await SharedPreferences.getInstance();
                            _check();
                            if (prefs.getString(widget.title) == null) {
                             
                              setState(() {
                                _join = "Joined";
                              });

                              addData();
                              userSaved();
                            } else {

                              setState(() {
                                _join = "Joined";
                              });
                            }
                          },
                          child: Container(
                            height: 50.0,
                            width: 180.0,
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            child: Center(
                              child: Text(
                                _join,
                                style: TextStyle(
                                    fontFamily: "Popins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
class joinEvent extends StatelessWidget {
  joinEvent({this.list});
  final List<DocumentSnapshot> list;

  @override
  Widget build(BuildContext context) {
    return 

    Container() ;
    //      Stack(
    //     children: <Widget>[
    //       Padding(
    //         padding: const EdgeInsets.only(left: 8.0),
    //         child: Container(
    //             height: 35.0,
    //             child: ListView.builder(
    //               scrollDirection: Axis.horizontal,
    //               padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0),
    //               itemCount: list.length > 3 ? 3 : list.length,
    //               itemBuilder: (context, i) {
    //                 String _title = list[i].data()['nama'].toString();
    //                 String _uid = list[i].data()['uid'].toString();
    //                 String _img = list[i].data()['photoProfile'].toString();

    //                 return Row(
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 2.0),
    //                       child: Container(
    //                         height: 35.0,
    //                         width: 35.0,
    //                         decoration: BoxDecoration(
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(70.0)),
    //                             image: DecorationImage(
    //                                 image: NetworkImage(_img),
    //                                 fit: BoxFit.cover)),
    //                       ),
    //                     ),
    //                   ],
    //                 );
    //               },
    //             )),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 6.0, left: 135.0),
    //         child: Text(
    //           list.length.toString() + " People Join",
    //           style: TextStyle(fontFamily: "Popins"),
    //         ),
    //       )
    //     ],
       
    // );
  }
  
}
*/
class joinEvent extends StatelessWidget {
  joinEvent({this.list});
  List<JoinEventModel> list;

  @override
  Widget build(BuildContext context) {
    return 

     
         Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
                height: 35.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0),
                  itemCount: list.length > 3 ? 3 : list.length,
                  itemBuilder: (context, i) {
                    String _title = list[i].name;
                    String _uid = list[i].npm;
                    String _img = list[i].photoProfile;

                    return Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Container(
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70.0)),
                                image: DecorationImage(
                                    image: NetworkImage(_img),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ],
                    );
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 135.0),
            child: Text(
              list.length.toString() + " People Join",
              style: TextStyle(fontFamily: "Popins"),
            ),
          )
        ],
       
    );
  }
  
}
class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String img, title, id;

  MySliverAppBar(
      {@required this.expandedHeight, this.img, this.title, this.id});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
        return Container();
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.clip,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            transitionOnUserGestures: true,
            tag: 'hero-tag-${id}',
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(img),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 130.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[
                        new Color(0x00FFFFFF),
                        new Color(0xFFFFFFFF),
                      ],
                      stops: [
                        0.0,
                        1.0
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 1.0)),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Icon(Icons.arrow_back),
                    ))),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 250.0,
              ),
            ),
            SizedBox(
              width: 25.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

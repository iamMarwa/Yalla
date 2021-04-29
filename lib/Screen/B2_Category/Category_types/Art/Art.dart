import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yalla_activities/Library/bubbleTabCustom/bubbleTab.dart';
import 'package:yalla_activities/Screen/B1_Home/Home_Search/search_page.dart';
import 'package:yalla_activities/Screen/B2_Category/Page_Transformer_Card/page_transformer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'category/allArts.dart';
import 'category/culinaryArts.dart';
import 'category/visualArts.dart';
import 'category/literaryArts.dart';
import 'category/performingArts.dart';

class art extends StatefulWidget {
  String userId;
  art({this.userId});

  _artState createState() => _artState();
}

class _artState extends State<art> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 5,
                      child: new Scaffold(
                        backgroundColor: Colors.white,
                        appBar: PreferredSize(
                          preferredSize:
                              Size.fromHeight(40.0), // here the desired height
                          child: new AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              centerTitle: true,
                              automaticallyImplyLeading: false,
                              title: new TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                unselectedLabelColor: Colors.black12,
                                labelColor: Colors.white,
                                labelStyle: TextStyle(fontSize: 19.0),
                                indicator: new BubbleTabIndicator(
                                  indicatorHeight: 36.0,
                                  indicatorColor: Color(0xFF928CEF),
                                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                ),
                                tabs: <Widget>[
                                  new Tab(
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                        fontSize: 11.2,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  new Tab(
                                    child: Text(
                                      "Visual arts",
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  new Tab(
                                    child: Text(
                                      "Literary arts",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  new Tab(
                                    child: Text(
                                      "Performing arts",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  new Tab(
                                    child: Text(
                                      "Culinary arts",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        body: new TabBarView(
                          children: [
                            allArts(
                              idUser: widget.userId,
                            ),
                            visualArts(
                              idUser: widget.userId,
                            ),
                            literaryArts(
                              idUser: widget.userId,
                            ),
                            performingArts(
                              idUser: widget.userId,
                            ),
                            culinaryArts(
                              idUser: widget.userId,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.clear)),
                Text(
                  "Art",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w800,
                      fontSize: 27.0,
                      letterSpacing: 1.5,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new SearchPage(
                                  idUser: widget.userId,
                                )));
                      },
                      child: Icon(
                        Icons.search,
                        size: 28.0,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

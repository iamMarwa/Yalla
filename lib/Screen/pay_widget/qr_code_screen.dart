/*
 * QR.Flutter
 * Copyright (c) 2019 the QR.Flutter authors.
 * See LICENSE for distribution and usage details.
 */

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yalla_activities/Screen/B1_Home/Home.dart';
import 'package:yalla_activities/Screen/B1_Home/choosplace_screen.dart';
import 'package:yalla_activities/Screen/pay_widget/cookie_button.dart';
import 'package:yalla_activities/constant.dart';

/// This is the screen that you'll see when the app starts
class QrCodeScreen extends StatefulWidget {
  String message2Code='';
  QrCodeScreen({this.message2Code});
  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
   

   
    return Material(
       color: mainBackgroundColor,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 280,
                    child:
                    QrImage(
  data: widget.message2Code,
  version: QrVersions.auto,
  size: 320,
  gapless: false,
)
                    // qrFutureBuilder,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                    .copyWith(bottom: 40),
                child: 
                 CookieButton(
            text: "Go Back",
            onPressed: () {
                                                    Navigator.push(
            context, MaterialPageRoute(builder: (context) => new 
        ChoosePalceScreen(currentUserId: currentUserIdconst)
            )
                                           );
                                          
            },
          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}

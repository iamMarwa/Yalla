import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yalla_activities/model/user_model.dart';
Color monteCarlo = Color(0xFF78CCC5);
Color alto = Color(0xFFD8D8D8);
Color jungleGreen = Color(0xFF24988D);
Color boulder = Color(0xFF7B7B7B);

Color mainBackgroundColor = monteCarlo;
Color closeButtonColor = alto;
Color mainButtonColor = jungleGreen;
Color mainTextColor = jungleGreen;
Color subTextColor = boulder;
Color dividerColor = alto;

  String currentUserIdconst='';
  UserModel currentUserModel;
const String squareLocationId = "REPLACE_ME";
const String applePayMerchantId = "REPLACE_ME";
const String squareApplicationId="sandbox-sq0idb-UAS1eX0hA-QFES3QuM54vw";
GeoPoint currentpositon_geo;
int distanceInKM=0;
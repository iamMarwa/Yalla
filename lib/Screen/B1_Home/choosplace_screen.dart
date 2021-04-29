import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yalla_activities/Library/loader_animation/loader.dart';
import 'package:yalla_activities/Library/loader_animation/dot.dart';
//import 'package:showcaseview/get_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalla_activities/Screen/Bottom_Nav_Bar/bottomNavBar.dart';
//import 'package:yalla_activities/Screen/pay_widget/buy_sheet.dart';

import 'package:yalla_activities/model/virtual_position.dart';
import 'package:yalla_activities/service/firestore_virtual_position.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yalla_activities/Screen/button_custom.dart';
import 'package:yalla_activities/Screen/B1_Home/Home.dart';

//import 'package:square_in_app_payments/models.dart';
//import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/google_pay_constants.dart'
//     as google_pay_constants;

import '../../constant.dart';

class ChoosePalceScreen extends StatefulWidget {
  String currentUserId;

  ChoosePalceScreen({this.currentUserId});
  @override
  _ChoosePalceScreenState createState() => _ChoosePalceScreenState();
}

class _ChoosePalceScreenState extends State<ChoosePalceScreen> {
bool isLoading1 = true;
  bool applePayEnabled = false;
  bool googlePayEnabled = false;

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();



  bool _isSelected = false;
  bool isLoading = false;
  String distanceValue='100';
  
    TextEditingController distanceController = new TextEditingController();
String currentpostion='';
String distance='';
String test='';

List<VirtualPosition> virtualcurrentPlace=[];
FireStoreVirtualPosition fireStoreVirtualPosition=new FireStoreVirtualPosition();
VirtualPosition selectedPosition;

@override
void     initState() 
{
  distanceController.text='100';
  distanceInKM=100;
test=widget.currentUserId;
  cuttentlocation();
    super.initState();
    

}
    
  ///
  ///  Create line horizontal
  ///
  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    ///
    /// Loading user for check email and password to firebase database
    ///
    return new Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: 
      // ()  {
         
      //   setState(() {
      //    cuttentlocation();
      //   });
      
      // }
      
      // ),
      // backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: true,

      ///
      /// Check loading for layout
      ///
      body: isLoading
          ? Center(
              child: ColorLoader5(
              dotOneColor: Colors.red,
              dotTwoColor: Colors.blueAccent,
              dotThreeColor: Colors.green,
              dotType: DotType.circle,
              dotIcon: Icon(Icons.adjust),
              duration: Duration(seconds: 1),
            ))

          ////
          /// Layout loading
          ///
          : 
          Container(
            height: MediaQuery.of(context).size.height*0.9,
            child:
          Stack(
              fit: StackFit.expand,
              children: <Widget>[
               
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0, right: 28.0, top: 100.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[

                              Image.asset("assets/image/address.png",height: MediaQuery.of(context).size.height*0.3,),
                            SizedBox(height: 20.0),
                           // Text("choose your current location",

                                // style: TextStyle(
                                //     fontFamily: "Popins",
                                //     fontSize:
                                //         30,
                                //     letterSpacing: 1.2,
                                //     color: Colors.black87,
                                //     fontWeight: FontWeight.bold)),

                                    
                                    Text(
                                     currentpostion,
                                style: TextStyle(
                                    fontFamily: "Popins",
                                    fontSize:
                                        30,
                                    letterSpacing: 1.2,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                                      Text(
                                    // getDistance(33.6546,34.342).toString(),
                                    distance,
                                style: TextStyle(
                                    fontFamily: "Popins",
                                    fontSize:
                                        30,
                                    letterSpacing: 1.2,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                                    //_createPositionDropDown(),
                                     Text("Enter the distance to Event in Km",
                                            style: TextStyle(
                                                fontFamily: "Popins",
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(30),
                                                letterSpacing: .9)),
                                        TextFormField(
                                          ///
                                          /// Add validator
                                          ///
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'choose distance in km';
                                            }
                                          },
                                          onChanged: (input){distanceInKM=int.parse(input); distance = input;},
                                          onSaved: (input) {distanceInKM=int.parse(input); distance = input;},
                                          controller: distanceController,
                                          keyboardType:
                                              TextInputType.number,
                                          style: TextStyle(
                                              fontFamily: "WorkSansSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            //border: InputBorder,
                                            icon: Icon(
                                              FontAwesomeIcons.directions,
                                              color: Colors.black45,
                                              size: 20.0,
                                            ),
                                            hintText: "choose distance",
                                            hintStyle: TextStyle(
                                                fontFamily: "Sans",
                                                fontSize: 15.0,
                                                letterSpacing: 1.5,
                                                color: Colors.black45),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(30),
                                        ),
                                        

                                        Material(
                                      color: Colors.black12,
                                      borderOnForeground: true,
                                      borderRadius: BorderRadius.circular(50),
                                      child: InkWell(
                                      //  splashColor: Colors.black12,
                                        onTap: () {
                                          setState(() {
                                            //tapLogin = 1;
                                          });
                                          //_Playanimation();
                                          //return tapLogin;
                                          Navigator.pop(context);
                                           Navigator.push(
            context, MaterialPageRoute(builder: (context) => new 
          BottomNavBar(
                                                                          pageIndex: 4,
                                                                          idUser: widget.currentUserId,
                                                                        )),
            
                                           );
                                          
                                        },
                                        child: ButtonCustom(txt: "show Event"),
                                      ),
                                    )
                          ],
                        ),

                      ]  
                    ),
                  ),
                )    
                
              ]
          ),
          )
            
    );
  }
 
    void cuttentlocation () async {


virtualcurrentPlace=  await fireStoreVirtualPosition.getvirtualposition();

  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  
 //Position position=Position(latitude:20.5937,longitude:78.9629);
 var places = await placemarkFromCoordinates(
  position.latitude,
  position.longitude,
  

 );

currentpositon_geo=new GeoPoint(position.latitude, position.longitude);
virtualcurrentPlace.add(VirtualPosition(name: 'current location',position: currentpositon_geo));

 if (places != null && places.isNotEmpty) {
   setState(() {
 currentpostion=places[0].thoroughfare+","+places[0].locality;    
 //getDistance(33.6546,44.342);
   });
 

  
  

 }
 //return "No address available";


}


 
//  Widget _createPositionDropDown() {
    
//     if(virtualcurrentPlace.length==0){
//       return Container();
//     }
//     else{
//     selectedPosition=virtualcurrentPlace[0];
//     return new DropdownButton<VirtualPosition>(
//             hint:Text("Choose Place"),
//              value:selectedPosition ,

//   items:  virtualcurrentPlace.map((VirtualPosition value) {
//     return new DropdownMenuItem<VirtualPosition>(
//       value: value,
//       child: new Text(value.name),
//     );
//   }).toList(),
//   onChanged: (value) {
      
//         setState(() {
//       selectedPosition=value;
   
//         });
//   });
//     }
 

//   }

}

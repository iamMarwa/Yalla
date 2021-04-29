import 'package:cloud_firestore/cloud_firestore.dart';

class VirtualPosition {
  String name;

  GeoPoint position;
   VirtualPosition({this.name,this.position});
  VirtualPosition.fromJson(Map <dynamic,dynamic> map){
    if(map==null){
      return;
    }

 
    position=map['position'];
    name=map['name'];
 
 
 
      }
    
    toJson(){
      return {
 
       'position':position,
       'name':name,

      };
    }

}
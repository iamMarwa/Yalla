import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String city,name,email,country,password,photoProfile,uid;

  
   UserModel({this.name,this.city,this.country,this.email,this.password,this.photoProfile,this.uid});
  UserModel.fromJson(Map <dynamic,dynamic> map){
    if(map==null){
      return;
    }
    city=map['city'];
    name=map['name'];
    email=map['email'];
    country=map['country'];
    password=map['password'];
    photoProfile=map['photoProfile'];
     uid=map['uid'];

 
 
 
      }
    
    toJson(){
      return {
 

'city':city,

    'name':name,
    'email':email,
    'country':country,
    'password':password,
    'photoProfile':photoProfile,
     'uid':uid,
      };
    }

}
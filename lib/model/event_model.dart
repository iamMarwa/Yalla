import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  
   String title = '';
            String category = '';
            String imageUrl = '';
            String id = '';
            String description ='';
            String price = '';
            String hours = '';
            String date = '';
            String location ='';
            String description2 ='';
            String description3 = '';
            String host_name = '';
            String type = '';
            GeoPoint positiononmap;
  EventModel({this.category,this.date,this.description,this.description2,this.description3,this.host_name,
  this.hours,this.id,this.imageUrl,this.location,this.price,this.title,this.type,this.positiononmap});
 EventModel.fromJson(Map <dynamic,dynamic> map){
    if(map==null){
      return;
    }

 
    
    
 
    title = map['title'];
            category = map['category'];
             imageUrl = map['imageUrl'];
             id = map['id'];
             description =map['desc1'];
            price = map['price'];
             hours = map['time'];
             date = map['date'];
             location =map['place'];
             description2 =map['desc2'];
             description3 = map['desc3'];
             host_name = map['host_name'];
             type =map['type'];
             positiononmap=map['positiononmap'];
 
      }
    
    toJson(){
      return {
 
    'title' :title,
            'category': category,
             'imageUrl' :imageUrl,
             'id' : id,
            'desc1' :description,
            
            'price' :price,
             
             'time' :hours,
             'date' :date,
             'place':location,
             'desc2' :description2,
             'desc3' :description3,
             'host_name' :host_name,
             'type' :type,
             'positiononmap':positiononmap,

      };
      }
}
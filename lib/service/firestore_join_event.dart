import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yalla_activities/Screen/B1_Home/allPopularEvent.dart';
import 'package:yalla_activities/model/join_event_model.dart';




class FireStoreJoinEvent{
  final CollectionReference _joinEventCollectionRef=
  FirebaseFirestore.instance.collection('JoinEvent');
  
  
  Future <DocumentSnapshot> getJoinEventId (String id) async {
    return await _joinEventCollectionRef.doc(id).get();

  }
  Future<List<JoinEventModel>> getJoinEvent(String eventTitle) async {
    var value = await _joinEventCollectionRef.doc("user").collection(eventTitle).get();
        return value.docs.map((e) =>JoinEventModel.fromJson(e.data())).toList();
  }


}
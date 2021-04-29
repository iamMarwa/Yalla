import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yalla_activities/model/virtual_position.dart';




class FireStoreVirtualPosition{
  final CollectionReference _virtualpositionCollectionRef=
  FirebaseFirestore.instance.collection('virtualPosition');
  
  Future <void> addvirtualpositionToFirstStore (VirtualPosition virtualposition)async{
    return await _virtualpositionCollectionRef.doc()
    .set(virtualposition.toJson());
  }
  Future <DocumentSnapshot> getvirtualpositionbyId (String virtualpositionid) async {
    return await _virtualpositionCollectionRef.doc(virtualpositionid).get();

  }
  Future<List<VirtualPosition>> getvirtualposition () async {
    var value = await _virtualpositionCollectionRef.get();
        return value.docs.map((e) =>VirtualPosition.fromJson(e.data())).toList();
  }


}
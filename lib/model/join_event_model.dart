class JoinEventModel{
  String name;
  String npm;
  String photoProfile;

  JoinEventModel({this.name,this.npm,this.photoProfile});
   JoinEventModel.fromJson(Map <dynamic,dynamic> map){
    if(map==null){
      return;
    }

 
    name=map['nama'];
    npm=map['npm'];
    photoProfile=map['photoProfile'];
 
 
 
      }
    
    toJson(){
      return {
 'nama':name,
       'npm':npm,
       'photoProfile':photoProfile,

      };
    }
}
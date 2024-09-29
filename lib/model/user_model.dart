class UserModel {
  String? name;
  String? email;
  String? password;
  String? pic;
  String? id;

  UserModel({this.email,this.id,this.name,this.password,this.pic});
  

Map<String,dynamic> toMap(){
  return{
    'name':this.name,
    'email':this.email,
    'password':this.password,
    'pic':this.pic,
    'id':this.id
  };
}
factory UserModel.fromMap(Map<String,dynamic>map){
  return UserModel(
    name:map['name']as String,
    email: map['email'] as String,
    password: map['password'] as String,
    pic:map['pic'] as String,
    id: map['id'] as String
  );
}

}
 

import 'package:firebaseproject/shared/enem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static  SharedPreferences? sharedPreferences;


 static init() async{
      sharedPreferences =await SharedPreferences.getInstance();
  }

 static putBool({required sharedKeys key,required value}){
    sharedPreferences?.setBool(key.name , value);
  }

 static getBool ( {required sharedKeys key}){
   return sharedPreferences?.get(key.name)??false;
  }

}
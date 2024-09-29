
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseproject/model/user_model.dart';
import 'package:firebaseproject/screens/favorit_screen.dart';
import 'package:firebaseproject/screens/profile_screens.dart';
import 'package:firebaseproject/shared/enem.dart';
import 'package:firebaseproject/shared/shared_pre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
 static AuthCubit get(context)=>BlocProvider.of(context);

 UserModel userModel=UserModel();
 FirebaseStorage fireStorage=FirebaseStorage.instance;
   
  checkUser()async{
   await FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently **************************** signed out!');
    } else {
      print('User is *************************** signed in!');
      emit(CheckSuccessState());
    }
  });
  }
    


   
  // registerByEmailAndPassword({String? name ,required String email
  //    ,required String password})async
  // {
  // try{
  // UserCredential credential=
  // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  // userModel.name = name ;
  // userModel.email = email ;
  // userModel.password = password;
  // userModel.id = credential.user!.uid;
  // await fireStorage
  //     .ref()
  //     .child("images/")
  //     .child("${userModel.id}.png}")
  //     .putFile(images!);
  // userModel.pic = await fireStorage
  //     .ref()
  //     .child("images/")
  //     .child("${userModel.id}.png}")
  //     .getDownloadURL();
  // await FirebaseFirestore.instance.collection('Users').doc(userModel.id).set(userModel.toMap());
  //   //await FirebaseStorage.instance;
  //    emit(RejestsuccessState());
    
   
  // } on FirebaseAuthException catch (e) {
  //                           if (e.code == 'weak-password') {
  //                             print('The password provided is too weak.');
  //                              emit(RejestFaluireStateUserWeakPassword(
  //                               message: 'The password provided is too weak.'));
  //                           } else if (e.code == 'email-already-in-use') {
  //                             print(
  //                                 'The account already exists for that email.');
  //                                 emit(RejestFaluireStateUserused(message:'The account already exists for that email.' ));
  //                           }
  //                         } catch (e) {
  //                           print(e);
  //                         }
    
  // }
  registerByEmailAndPassword({String? name ,required String email
     ,required String password})async
  {
  try{
  UserCredential credential=
  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  userModel.name = name ;
  userModel.email = email ;
  userModel.password = password;
  userModel.id = credential.user!.uid;
  await fireStorage
      .ref()
      .child("images/")
      .child("${userModel.id}.png}")
      .putFile(File(image!.path));
  userModel.pic = await fireStorage
      .ref()
      .child("images/")
      .child("${userModel.id}.png}")
      .getDownloadURL();

    await FirebaseFirestore.instance.collection("Users").doc(userModel.id).set(userModel.toMap());
    emit(RejestsuccessState());
  } on FirebaseAuthException catch(error){
    print("***************Failed with error code :${error.code} ${error.message}");
  }
  }





                    

loginByEmailAndPassword({required String email,required String password})async{
    try {
  UserCredential userCredential=
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  var userData= await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid)
     .get();
  userModel = UserModel.fromMap(userData.data()!);
     emit(LoginSuccessState());
} on FirebaseAuthException catch (e) {
  print('@ERROR: Login: ${e.toString()}');
                if (e.code == 'user-not-found') {
                print('No user found for that email.');
                emit(LoginFaluireStateUserNotfound(message: 'No user found for that email.'));
                
            } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            emit(LoginFaluireStateUserRongPassword(message: 'Wrong password provided for that user.'));
            } else if (e.code == 'invalid-email'){
                print('No user found for that email.');
                emit(LoginFaluireStateUserNotfound(message: 'No email found.'));
            }else if (e.code == 'invalid-credential'){
                print('No user found for that email.');
                emit(LoginFaluireStateUserNotfound(message: 'Rong password.'));
            }
                
            
  }}




  singOut(){
    FirebaseAuth.instance.signOut();
  
    emit(SignOutSuccessState());
  }


  XFile? image; //path
  File? images; 
  
 uploadImage()async{
  final ImagePicker picker = ImagePicker();
// Pick an image.
 image = await (picker.pickImage(source: ImageSource.gallery));
  
 if (image !=null) {
  images=File(image!.path);
  await fireStorage.ref().child('images/').child('${userModel.id} .png').putFile( File(image!.path));
  emit(PickgallerySuccessState());
  return images!.readAsBytes();
}
else{
  print('no select image');
}
 }
 

  insertData({required String name,required String phone})async{
    await fireStorage
      .ref()
      .child("images/")
      .child("${name}.png}")
      .putFile(File(image!.path));

      String id = FirebaseFirestore.instance
    .collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('UniqData').doc().id;

    await FirebaseFirestore.instance
    .collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('UniqData').doc(id).set({
      'name':name,
      'phone':phone,
       'id': id,
      
      'image': await fireStorage
      .ref()
      .child("images/")
      .child("${name}.png}")
      .getDownloadURL(),
      'type':'Not Favorite'
    });
    personalData=[];
    getUniqData();
    emit(AddDataSuccess());
  }
int currentIndex=0;
  navChande(index){
    currentIndex=index;
    emit(NavGhangeSuccessState());
  }
 List<Widget> screens= [
  ProfileScreens(),
  FavoritScreen()
 ];
 bool isShowBottom=false;
 IconData iconBottom=Icons.account_circle_rounded;
 changeBottomShet({required bool isShow,required IconData iconData}){
  isShowBottom=isShow;
  iconBottom=iconData;
  emit(ChangeBottomSuccess());

 }
  List<QueryDocumentSnapshot> personalData=[];
   getUniqData()async{
     emit(LoadingPersonalDataLoading());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('UniqData').get();
      personalData.addAll(querySnapshot.docs);
//       .then(value){
// for (DocumentSnapshot<Map<String, dynamic>> element in value.docs) {
//         personalData.add(element);
//       }
      emit(successPersonalDataLoading());
      }
      List Favorit=[];
      getFavoritData()async{
        Favorit=[];
        personalData=[];
          await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('UniqData').where('type' ,isEqualTo: 'Favorite').get().then((value){
            for (var element in value.docs) {
             
                Favorit.add(element.data());
              
            }
            emit(GetFavoriteDataSuccess());
          });
      }
      
  //     then(value){
  //     {
  //     for (DocumentSnapshot<Map<String, dynamic>> element in value.docs) {
  //       personalData.add(element);
  //     }
  //     emit(successPersonalDataLoading());
      
  //  }

  
 updateFavoriteData({required String id,required String? type}) async{
  await FirebaseFirestore.instance
  .collection('Users')
  .doc(FirebaseAuth.instance.currentUser!.uid.toString())
  .collection('UniqData')
  .doc(id).update({
    'type':type
  });
  Favorit =[];
  getFavoritData();
  personalData=[];
  getUniqData();
 }
 updateData({required String id,String?name,String?phone,})async{
  emit(LoadingUpdate());
  await fireStorage
      .ref()
      .child("images/")
      .child("${name}.png}")
      .putFile(images!);
 await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection('UniqData').doc(id).update({
  'name':name,
  'phone':phone,
  'image':await fireStorage
      .ref()
      .child("images/")
      .child("${name}.png}")
      .getDownloadURL(),
     
 });
  Favorit =[];
  getFavoritData();
 personalData=[];
 getUniqData();
  emit(UpdateSuccessState());

 }
 deletDate({required String id})async{
  await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection('UniqData').doc(id).delete();
  personalData=[];
 getUniqData();
  Favorit =[];
  getFavoritData();
 emit(DeletSuccessState());
}



  bool isDark=false;
  ChangeThem(){
  isDark= !isDark;
  CashHelper.putBool(key:sharedKeys.isDarkKey,value: isDark);
  emit(ChangeThemSuccess());
}
 getThem(){
   isDark= CashHelper.getBool(key: sharedKeys.isDarkKey);
 }



 

}
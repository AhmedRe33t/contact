import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseproject/cubit/auth_cubit.dart';
import 'package:firebaseproject/function/update.dart';
import 'package:firebaseproject/widgets/defultText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoritScreen extends StatelessWidget {
   FavoritScreen({super.key});
         CountryCode myCountry=CountryCode(name:'EG',dialCode:'+20');

  @override
  Widget build(BuildContext context) {
    return
    
    BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        
        return
     Scaffold(
        

      // appBar: AppBar(title: 
      //const Text('Favorite_Page'),),
      body: 
        
        ListView.separated(
          
          
           separatorBuilder: (BuildContext context, int index)=>  SizedBox.fromSize(),
            itemCount: AuthCubit.get(context).Favorit.length,
          
          itemBuilder: (BuildContext context, int index) {
            print('Favourite List: id ${cubit.Favorit[index]['id']}');
          return 
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                cubit.deletDate(id: cubit.Favorit[index]['id']);
              },
              child: InkWell(
                onLongPress: () {
                  AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              title: 'whitch one you want....',
              desc: '',
              btnCancelText: 'Delet' ,
              btnCancelOnPress: () {
                cubit.deletDate(id: cubit.Favorit[index]['id']);
              },
              btnOkText:'Update',
              btnOkOnPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdatePage(id: cubit.Favorit[index]['id'])));
              },
              ).show();
                },
                onTap: (){
                  Fluttertoast.showToast(
                      msg: "on long press Updete or delet and swap delet",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Color.fromARGB(255, 32, 31, 31),
                      fontSize: 16.0
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal
                  ),
                    
                    padding:const EdgeInsets.all(16),
                    
                    child:Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: 
                         
                          NetworkImage(cubit.Favorit[index]['image']??'') ,
                        ),
                   Column(
                      children: [
                        CustomText(text: '${cubit.Favorit[index]['name']}'),
                       CustomText(text: ' ${myCountry} ${cubit.Favorit[index]['phone']}'),
                       
                      ],
                    ),
                   // cubit.personalData[index]['type'] == 'Not Favorite'? const Icon(Icons.favorite,color: Colors.grey,):const Icon(Icons.favorite,color: Colors.red,)
                   Visibility(
                    visible: cubit.Favorit[index]['type'] == 'Not Favorite',
                   replacement: IconButton(onPressed: (){
                    cubit.updateFavoriteData(id: cubit.Favorit[index]['id'],type: 'Not Favorite');
                   }, icon: const Icon(Icons.favorite,color: Colors.red)) ,
                    child:IconButton(onPressed: (){
                      cubit.updateFavoriteData(id: cubit.Favorit[index]['id'],type: 'Favorite');
                    }, 
                    icon:const Icon(Icons.favorite,color: Colors.grey)))
                  ])
                            ),
                ),
              ),
            );
          },
        )

    );}); 
  }
}
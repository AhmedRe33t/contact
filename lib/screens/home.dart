
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebaseproject/cubit/auth_cubit.dart';

import 'package:firebaseproject/model/user_model.dart';
import 'package:firebaseproject/shared/enem.dart';
import 'package:firebaseproject/shared/shared_pre.dart';
import 'package:firebaseproject/widgets/defualt_phone_field.dart';
import 'package:firebaseproject/widgets/defultFormField.dart';
import 'package:firebaseproject/widgets/defultText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';


class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
   GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();
   GlobalKey<FormState> formKey=GlobalKey<FormState>();
   TextEditingController nameController=TextEditingController();
   TextEditingController phoneController=TextEditingController();
   CountryCode myCountry=CountryCode(name:'EG',dialCode:'+20');
   List screensName=[
    'Contact_Page',
    'Favorite_Page'
   ];
   

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);

        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            backgroundColor: Color.fromARGB(255, 204, 204, 204),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                   Row(
                    children: [
                      CircleAvatar(
                       backgroundImage: NetworkImage(cubit.userModel.pic??''),
                      ),
                  Text(cubit.userModel.name?? ''),
                    ],
                  ),
                  Row(
                    children: [
                    const  CustomText(text: 'Login out...'),
                     const SizedBox(width: 100,),
                      IconButton(
                    onPressed: () {
                      AuthCubit.get(context).singOut();
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    icon: const Icon(Icons.backup_rounded))
                    ],
                  )
                ],
              ),
            ),
          ),
          appBar: AppBar(
            
            title: Text(screensName[cubit.currentIndex]),
            actions: [
              Switch(
                value:cubit.isDark ,
                 onChanged: (change){
                   cubit.ChangeThem();
                //   cubit.isDark =CashHelper.getBool(key: sharedKeys.isDarkKey);
                 }),
              IconButton(
                  onPressed: () {
                    AuthCubit.get(context).singOut();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  icon: const Icon(Icons.backup_rounded))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 121, 118, 118),
              onTap: (index) {
                cubit.navChande(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Contact'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorite'),
              ]),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child:const Icon(Icons.add),
            onPressed: () {
            Navigator.pushNamed(context, 'Add');}

          //   if(cubit.isShowBottom){
          //     if(formKey.currentState!.validate()){
          //     await  cubit.insertData(
          //         name: nameController.text,
          //         phone: '${myCountry.dialCode}${phoneController.text}'
          //       );
          //     }
          //   }else{
          //     cubit.changeBottomShet(isShow: true, iconData: Icons.add);
          //     scaffoldKey.currentState!.showBottomSheet((context)=>Wrap(
          //     children: [
          //       Container(
                  
          //         height: 300,
          //          padding: EdgeInsets.symmetric(
          //                 vertical: 10, horizontal: 10),

          //         child: Form(
          //           key: formKey,
          //           child: Column(
          //             mainAxisSize:MainAxisSize.min,
          //             children: [
          //                 Align(
          //                     alignment: Alignment.topRight,
          //                     child: TextButton(
          //                         onPressed: () {
          //                           Navigator.pop(context);
          //                         },
          //                         child: const Icon(Icons.clear,color: Colors.white,size: 30,)),
          //                   ),

          //               CustomFormField(
          //                 radius: 20,
          //                backgroundColor:Colors.teal,
          //                 controller: nameController,
          //                  keyboardType: TextInputType.name,
          //                  validator: (value){
          //                   if(value!.isEmpty){
          //                     return 'please set data';
          //                   }
          //                     return null;
                            
          //                  },
          //                  prefixIcon:const Icon( Icons.title),
          //                  hintText: 'name...',
          //                  ),
          //                  DefaultPhoneField(
                            
          //                   controller:phoneController , 
          //                  validator: (value) { 
          //                   if(value!.isEmpty){
          //                     return 'please enter the phone number';
          //                   }
          //                   return null;
          //                   },
          //                   labelText: 'phone number',
          //                   onChange: (CountryCode){
          //                     myCountry=CountryCode;
          //                   },
          //                   hintText: 'phone number',
          //                   ),
          //                  const SizedBox(
          //                     height: 10,
          //                   ),
          //                   TextButton(
          //                     onPressed: (){
          //                       AuthCubit.get(context).uploadImage();
          //                     }, 
          //                     child:const Text('select your photo'))
          //             ],
          //           ),
          //         ),
          //       )
          //     ],
          //   )
          //   ).closed.then((value) {
          //     phoneController.clear();
          //     nameController.clear();
          //     cubit.changeBottomShet(isShow: false, iconData: Icons.account_circle_rounded); })
            
          //   ;
          // }
          // },
          )
          ,
        );
      },
    );
  }
}

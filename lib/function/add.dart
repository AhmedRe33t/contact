import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebaseproject/cubit/auth_cubit.dart';
import 'package:firebaseproject/widgets/defualt_phone_field.dart';
import 'package:firebaseproject/widgets/defultFormField.dart';
import 'package:firebaseproject/widgets/defultText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddData extends StatelessWidget {
  AddData({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
     CountryCode myCountry=CountryCode(name:'EG',dialCode:'+20');


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const CustomText(
              text: 'Add Data....',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: ListView(
                children: [
                  CustomFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    hintText: 'name...',
                    inputBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 30, 104, 164))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultPhoneField(
                            
                            controller:phoneController , 
                           validator: (value) { 
                            if(value!.isEmpty){
                              return 'please enter the phone number';
                            }
                            return null;
                            },
                            labelText: 'phone number',
                            onChange: (CountryCode){
                              myCountry=CountryCode;
                            },
                            hintText: 'phone number',
                            ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.teal)),
                      onPressed: () {
                        AuthCubit.get(context).uploadImage();
                      },
                      child: const CustomText(
                          text: 'Add your image..',
                          fontSize: 20,
                          color: Color.fromARGB(255, 10, 10, 10))),
                  const SizedBox(
                    height: 20,
                  ),
                  // MaterialButton(
                  // onPressed: (){

                  // },
                  // child:const CustomText(text: 'Update..',fontSize: 23,color: Color.fromARGB(255, 151, 28, 19),),
                  // ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 14, 52, 177))),
                      onPressed: () {
                        AuthCubit.get(context).insertData(
                          name: nameController.text,
                           phone: phoneController.text);
                        Navigator.pop(context);

                      },
                      child: const CustomText(
                          text: 'Add...',
                          fontSize: 23,
                          color: Color.fromARGB(255, 17, 16, 16))),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 205, 15, 5))),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'profile');
                      },
                      child: const CustomText(
                          text: 'Cancel..',
                          fontSize: 23,
                          color: Color.fromARGB(255, 26, 23, 23)))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

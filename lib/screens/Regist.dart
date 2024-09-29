import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/constant.dart';
import 'package:firebaseproject/cubit/auth_cubit.dart';
import 'package:firebaseproject/cubit/obsecure_cubit.dart';
import 'package:firebaseproject/cubit/obsecure_state.dart';
import 'package:firebaseproject/widgets/defultFormField.dart';
import 'package:firebaseproject/widgets/defultText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistPage extends StatelessWidget {
  const RegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RejestFaluireStateUserWeakPassword) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: state.message,
          ).show();
        }
        if (state is RejestFaluireStateUserused) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: state.message,
          ).show();
        }
      },
      builder: (context, state) {
        AuthCubit cubit = BlocProvider.of<AuthCubit>(context);

        return Scaffold(
          appBar: AppBar(
            title: const CustomText(
              text: 'Regest_Page',
              fontSize: 25,
              color: Color.fromARGB(255, 2, 36, 63),
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.teal,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const CustomText(
                    text: 'Regist',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  const CustomText(
                    text: 'Regist to countinue useing the app..',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const CustomText(
                    text: 'Email..',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 49, 88),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: CustomFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'valid data';
                        }
                      },
                      hintText: 'Enter your email...',
                      suffixIcon: const Icon(Icons.email),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      inputEnabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(20)),
                      inputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    text: 'Password..',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 49, 88),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: BlocProvider(
                      create: (context) => ObsecureCubit(),
                      child: BlocBuilder<ObsecureCubit, ObsecureState>(
                        builder: (context, state) {
                          return CustomFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'valid data';
                              }
                            },
                            obscureText: ObsecureCubit.get(context).obsecure,
                            hintText: 'Enter your password...',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  ObsecureCubit.get(context).changeObsecure();
                                },
                                icon: ObsecureCubit.get(context).obsecure
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            controller: PasswordController,
                            keyboardType: TextInputType.number,
                            inputEnabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(20)),
                            inputBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(20)),
                          );
                        },
                      ),
                    ),
                  ),
                  const CustomText(
                    text: 'name..',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 49, 88),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'valid data';
                        }
                      },
                      hintText: 'Enter your name...',
                      suffixIcon: const Icon(Icons.person),
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      inputEnabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(20)),
                      inputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        AuthCubit.get(context).uploadImage();
                      },
                      child: const CustomText(
                        text: 'please select your photo',
                        color: const Color.fromARGB(255, 4, 42, 73),
                        fontWeight: FontWeight.bold,
                      )),
                  MaterialButton(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.teal,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthCubit.get(context).registerByEmailAndPassword(
                              email: emailController.text,
                              password: PasswordController.text,
                              name: nameController.text);

                          // registWithEmailAndPassword(
                          //   name: nameController.text,
                          //     email: emailController.text,
                          //     password: PasswordController.text);
                          //   if(FirebaseAuth.instance.currentUser!.emailVerified)
                          Navigator.of(context).pushReplacementNamed('login');
                          emailController.clear();
                          PasswordController.clear();
                          nameController.clear();
                        }
                      },
                      child: const CustomText(
                        text: 'Regist',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 55, 94),
                        fontSize: 25,
                      )),
                     const SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                        child:const CustomText(
                            text: 'I have an acount actually',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.teal,
                          ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

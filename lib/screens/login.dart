import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/cubit/auth_cubit.dart';
import 'package:firebaseproject/cubit/obsecure_cubit.dart';
import 'package:firebaseproject/cubit/obsecure_state.dart';
import 'package:firebaseproject/widgets/defultFormField.dart';
import 'package:firebaseproject/widgets/defultText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    //GlobalKey<ScaffoldState> scaffoldForm=GlobalKey<ScaffoldState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginFaluireStateUserNotfound) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: state.message,
          ).show();
        }
        if (state is LoginFaluireStateUserRongPassword) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: state.message,
          ).show();
        }
        if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, 'home');
        }
      },
      builder: (context, state) {
        AuthCubit cubit = BlocProvider.of<AuthCubit>(context);
        return Scaffold(
          //key: scaffoldForm,
          appBar: AppBar(
            title: const CustomText(
              text: 'Login_Page',
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
                    text: 'Login',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  const CustomText(
                    text: 'Login to countinue useing the app..',
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
                          return 'enter the valied data';
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
                                return 'enter the valied data';
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
                            keyboardType: TextInputType.emailAddress,
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
                  const Align(
                      alignment: Alignment.bottomRight,
                      child: CustomText(
                        text: 'Forget the password..?',
                        color: Color.fromARGB(255, 202, 27, 14),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.teal,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // cubit.loginWithEmailAndPassword(
                          //     email: emailController.text,
                          //     password: PasswordController.text);
                          //     if(FirebaseAuth.instance.currentUser!.emailVerified){
                          //     Navigator.pushReplacementNamed(context, 'home');}
                          //     else{

                          //        AwesomeDialog(
                          //     context: context,
                          //     dialogType: DialogType.error,
                          //     animType: AnimType.rightSlide,
                          //     title: 'Error',
                          //     desc: 'please verified your email',
                          //   ).show();
                          //     }

                          await AuthCubit.get(context).loginByEmailAndPassword(
                              password: PasswordController.text,
                              email: emailController.text);

                          //loginWithEmailAndPassword(email: emailController.text, password: PasswordController.text);
                          // if( FirebaseAuth.instance.currentUser!.emailVerified)
                          //   Navigator.pushReplacementNamed(context, 'home');
                          //  if(credential.user!.emailVerified){
                          //   Navigator.pushReplacementNamed(context, 'home');}
                          //   else{
                          //    AwesomeDialog(
                          //           context: context,
                          //           dialogType: DialogType.error,
                          //           animType: AnimType.rightSlide,
                          //           title: 'Error',
                          //           desc: 'please verified your email',
                          //         ).show();
                          //  }
                        }
                      },
                      child: const CustomText(
                        text: 'Login',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 55, 94),
                        fontSize: 25,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: MaterialButton(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.teal,
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Login with google..   ',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 55, 94),
                              fontSize: 20,
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/4.png'),
                              radius: 20,
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('regist');
                    },
                    child: const Row(
                      children: [
                        CustomText(
                          text: 'Dont have an account... ',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        CustomText(
                          text: 'Regist!',
                          color: Color.fromARGB(255, 165, 18, 7),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ],
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

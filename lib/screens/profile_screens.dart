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

class ProfileScreens extends StatefulWidget {
  ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  CountryCode myCountry = CountryCode(name: 'EG', dialCode: '+20');
  String name = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // if(state is LoadingPersonalDataLoading){
        //    CircularProgressIndicator();
        // }
      },
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);

          return Scaffold(
             

              //appBar: AppBar(title: const Text('Profile_Page'),),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Search',
                        hintText: 'search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('UniqData')
                          .snapshots(),
                      builder: (context, snapshot) {
                        return (snapshot.connectionState ==
                                ConnectionState.waiting)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Expanded(
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox.fromSize(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {

                                      var data = snapshot.data!.docs[index]
                                          .data() as Map<String, dynamic>;

                                          // print('Favourite List: id ${cubit
                                                //    .personalData[index].id}');

                                      if (name.isEmpty) {
                                        return Dismissible(
                                          key: UniqueKey(),
                                          onDismissed: (direction) {
                                            cubit.deletDate(
                                                id: cubit
                                                    .personalData[index].id);
                                          },
                                          child: InkWell(
                                            onLongPress: () {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.info,
                                                animType: AnimType.rightSlide,
                                                title:
                                                    'whitch one you want.... ',
                                                desc: '',
                                                btnCancelText: 'Delet',
                                                btnCancelOnPress: () {
                                                  cubit.deletDate(
                                                      id: cubit
                                                          .personalData[index]
                                                          .id);
                                                },
                                                btnOkText: 'Update',
                                                btnOkOnPress: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              UpdatePage(
                                                                  id: cubit
                                                                      .personalData[
                                                                          index]
                                                                      .id)));
                                                },
                                              ).show();
                                            },
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "on long press Updete or delet and swap delet",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 3,
                                                  backgroundColor: Colors.red,
                                                  textColor:
                                                      const Color.fromARGB(
                                                          255, 32, 31, 31),
                                                  fontSize: 16.0);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.teal),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage:
                                                              //FileImage(cubit.personalData[index]['image'])
                                                              NetworkImage(data[
                                                                      'image'] ??
                                                                  ''),
                                                        ),
                                                        Column(
                                                          children: [
                                                            CustomText(
                                                                text:
                                                                    '${data['name']}'),
                                                            CustomText(
                                                                text:
                                                                    '${data['phone']}'),
                                                          ],
                                                        ),
                                                        // cubit.personalData[index]['type'] == 'Not Favorite'? const Icon(Icons.favorite,color: Colors.grey,):const Icon(Icons.favorite,color: Colors.red,)
                                                        Visibility(
                                                            visible: data[
                                                                    'type'] ==
                                                                'Not Favorite',
                                                            replacement:
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      cubit.updateFavoriteData(
                                                                          id: cubit
                                                                              .personalData[index]
                                                                              .id,
                                                                          type: 'Not Favorite');
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Colors
                                                                            .red)),
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  cubit.updateFavoriteData(
                                                                      id: cubit
                                                                          .personalData[
                                                                              index]
                                                                          .id,
                                                                      type:
                                                                          'Favorite');
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .grey)))
                                                      ])),
                                            ),
                                          ),
                                        );
                                      }
                                      if (data['name']
                                          .toString()
                                          .toLowerCase()
                                          .contains(name.toLowerCase())) {
                                        return Dismissible(
                                          key: UniqueKey(),
                                          onDismissed: (direction) {
                                            cubit.deletDate(
                                                id: cubit
                                                    .personalData[index].id);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onLongPress: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.info,
                                                  animType: AnimType.rightSlide,
                                                  title:
                                                      'whitch one you want....',
                                                  desc: '',
                                                  btnCancelText: 'Delet',
                                                  btnCancelOnPress: () {
                                                    cubit.deletDate(
                                                        id: cubit
                                                            .personalData[index]
                                                            .id);
                                                  },
                                                  btnOkText: 'Update',
                                                  btnOkOnPress: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                UpdatePage(
                                                                    id: cubit
                                                                        .personalData[
                                                                            index]
                                                                        .id)));
                                                  },
                                                ).show();
                                              },
                                              onTap: () {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "on long press Updete or delet and swap delet",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 3,
                                                    backgroundColor: Colors.red,
                                                    textColor:
                                                        const Color.fromARGB(
                                                            255, 32, 31, 31),
                                                    fontSize: 16.0);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:const Color.fromARGB(
                                                          212, 4, 77, 246)),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage:
                                                              //FileImage(cubit.personalData[index]['image'])
                                                              NetworkImage(
                                                                  data['image'] ??
                                                                      ''),
                                                        ),
                                                        Column(
                                                          children: [
                                                            CustomText(
                                                                text:
                                                                    '${data['name']}'),
                                                            CustomText(
                                                                text:
                                                                    '${ myCountry } ${data['phone']}'),
                                                          ],
                                                        ),
                                                        // cubit.personalData[index]['type'] == 'Not Favorite'? const Icon(Icons.favorite,color: Colors.grey,):const Icon(Icons.favorite,color: Colors.red,)
                                                        Visibility(
                                                            visible: data[
                                                                    'type'] ==
                                                                'Not Favorite',
                                                            replacement:
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      cubit.updateFavoriteData(
                                                                          id: cubit
                                                                              .personalData[
                                                                                  index]
                                                                              .id,
                                                                          type:
                                                                              'Not Favorite');
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Colors
                                                                            .red)),
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  cubit.updateFavoriteData(
                                                                      id: cubit
                                                                          .personalData[
                                                                              index]
                                                                          .id,
                                                                      type:
                                                                          'Favorite');
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .grey)))
                                                      ])),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container();
                                    }),
                              );
                      }),
                ],
              ));
        });
      },
    );
  }
}

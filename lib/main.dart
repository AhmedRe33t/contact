import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseproject/cubit/auth_cubit.dart';

import 'package:firebaseproject/firebase_options.dart';
import 'package:firebaseproject/function/add.dart';
import 'package:firebaseproject/function/update.dart';
import 'package:firebaseproject/screens/Regist.dart';
import 'package:firebaseproject/screens/favorit_screen.dart';
import 'package:firebaseproject/screens/home.dart';
import 'package:firebaseproject/screens/login.dart';
import 'package:firebaseproject/screens/profile_screens.dart';
import 'package:firebaseproject/shared/shared_pre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void>firebaseMassagingBackGroungHandler(RemoteMessage message)async{
 await Firebase.initializeApp();
 print('handler $message');
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
//Bloc.observer = MyBlocObserver();

 //  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMassagingBackGroungHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
    sound: true,
    alert: true
  );
  
  CashHelper.init;

  
  runApp(
  //  EasyLocalization(
  //     supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
  //     path: 'assets/translation', // <-- change the path of the translation files 
  //     fallbackLocale: Locale('en', 'US'),
  //     child:
    const   MyApp()) ;
   // );
    
}

 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  
  void initState() {

final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();
        

final InitializationSettings initializationSettings = InitializationSettings(
  iOS: initializationSettingsDarwin,);
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    RemoteNotification ? notification=message.notification;
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails(threadIdentifier: 'thread_id');

  });
  // final AndroidInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //       requestAlertPermission: true,
  //       requestBadgePermission: true,
  //       requestSoundPermission: true,
  //       onDidReceiveLocalNotification: (id, title, body, payload) async {},
  //     );

   
   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(notification.title ?? 'No Title'),
            content: SingleChildScrollView(
              child: Column(
                children: [Text(notification.body ?? 'No Body')],
              ),
            ),
          ),
        );
      }});
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
    
 
        //  IOSNotificationDetails iOSPlatformChannelSpecifics =
        //     IOSNotificationDetails(
        //   sound: 'default',
        // );


        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(

          //iOS: iOSPlatformChannelSpecifics,
        );

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          platformChannelSpecifics,
        );
      }
    });

   


   

    super.initState();
  }
  
  @override 
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit()
            ..checkUser()
            ..getUniqData()
            ..getFavoritData()..getThem(),
        ),
        // BlocProvider<ContactCubit>(
        //   create: (BuildContext context) => ContactCubit(),
        // ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return MaterialApp(
      //     localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
            theme: AuthCubit.get(context).isDark
                ? ThemeData.dark()
                : ThemeData.light(),

            // theme: ThemeData(

            //  scaffoldBackgroundColor: const Color.fromARGB(255, 169, 163, 163),
            //     appBarTheme: const AppBarTheme(
            //   color: Colors.teal,
            //   shadowColor: Color.fromARGB(255, 3, 64, 114),
            //   iconTheme: IconThemeData(color: Color.fromARGB(255, 6, 97, 172)),
            // )),
            home: LoginPage(),
            routes: {
              'login': (_) => const LoginPage(),
              'regist': (_) => const RegistPage(),
              'home': (_) => HomePage(),
              'profile': (_) => ProfileScreens(),
              'favorite': (_) => FavoritScreen(),
              'Add': (_) => AddData(),
            },
          );
        },
      ),
    );
  }
}

import 'package:eventh/screens/screens.dart';
import 'package:eventh/services/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        ChangeNotifierProvider(create: ( _ ) => EventsService() ),
      ],
      child: const MyApp(),
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EventH',
      initialRoute: 'checking',
      routes: {
        'checking': ( _ )  => const CheckAuthScreen(),
        'login'   : ( _ )  => const LoginScreen(),
        'home'    : ( _ )  => const HomeScreen(),
        'register': ( _ )  => const RegisterScreen(),
        'details' : ( _ )  => const DetailsScreen(),


      },
       scaffoldMessengerKey: NotificationsService.messengerKey,
        theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 224, 224, 224),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }   
}
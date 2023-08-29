

import 'package:eventh/services/services.dart';
import 'package:eventh/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    final eventService = Provider.of<EventsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return  Scaffold(
       appBar: AppBar(
        title: const Text('EventH', style: TextStyle(color: Colors.white)),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon( Icons.login_outlined ),
            onPressed: () {

            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');

          },
        )],
      ),
         body: SingleChildScrollView(
        child: Column(
          children: [

            // Tarjetas principales
            CardSwiper(events: eventService.events),

            
          ],
        ),
      )
    );
  }
}
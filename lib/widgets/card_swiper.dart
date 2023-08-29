import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:eventh/models/models.dart';



class CardSwiper extends StatelessWidget {

  final List<Event> events;


  const CardSwiper({
    Key? key, 
    required this.events
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if( events.isEmpty) {
      return  Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

  

    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      width: double.infinity,
      height: size.height * 0.9,
      child: Swiper(
        itemCount: events.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.9,
        itemHeight: size.height * 0.7,
        itemBuilder: ( _ , int index ) {

          final event = events[index];

           event.id = 'swiper-${ event.id }';
          

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: event),
            child: Hero(
              tag: event.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage( event.image ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
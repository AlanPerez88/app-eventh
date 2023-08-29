import 'package:eventh/models/models.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( event ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle( event ),
              _Overview( event ),
              _Overview( event ),
              _Overview( event ),
              _AudioPlayerButton()
              // CastingCards( event.id )
            ])
          )
        ],
      )
    );
  }
}


class _CustomAppBar extends StatelessWidget {

  final Event event;

  const _CustomAppBar( this.event );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only( bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
              event.name,
              style: const TextStyle( fontSize: 16 ),
              textAlign: TextAlign.center,
            ),
        ),

        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage( event.image ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {
  
  final Event event;


  const _PosterAndTitle( this.event );


  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only( top: 20 ),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          Hero(
            tag: event.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage( event.image ),
                height: 150,
              ),
            ),
          ),

          const SizedBox( width: 20 ),

          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: size.width - 210 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                
                Text( event.name, style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2 ),
                
                Text( event.detail, style: textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2),

                Row(
                  children: [
                    const Icon( Icons.star_outline, size: 15, color: Colors.grey ),
                    const SizedBox( width: 5 ),
                    Text( '3', style: textTheme.bodySmall )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {

  final Event event;

  const _Overview(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
      child: Text(
        event.detail,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}


class _AudioPlayerButton extends StatelessWidget {
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            await player.play(UrlSource('https://p.scdn.co/mp3-preview/1018d9eec93e59419426f0fb2b1da409b043661a?cid=ed39ab3239754f0ca3cda04314c50dbc'));
          },
          child: const Text('Reproducir Audio'),
        ),
      ),
    );
  }
}
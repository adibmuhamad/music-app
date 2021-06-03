import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/theme.dart';

class SongCard extends StatelessWidget {

  SongInfo song;

  SongCard(this.song);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 150,
              height: MediaQuery.of(context).size.width - 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width),
                gradient: LinearGradient(
                  colors: [shadowColor, whiteColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      offset: Offset(8, 6),
                      blurRadius: 12),
                  BoxShadow(
                      color: whiteColor,
                      offset: Offset(-8, -6),
                      blurRadius: 12),
                ],
              ),
            ),
            Positioned(
                top: 10,
                left: 10,
                right: 10,
                bottom: 10,
                child: CircleAvatar(
                    backgroundImage:
                    (song.albumArtwork == null) ?
                    Image.asset('assets/images/icon.png').image
                    :  Image.file(File(song.albumArtwork)).image,
                ),
            ),
          ],
        ),
        SizedBox(
          height: 100,
        ),
        Text(
          (song.title == null) ? 'Unknown' : song.title,
          style: regulerTextStyle.copyWith(
              fontSize: 20
          ),
        ),
      ],
    );
  }
}

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/theme.dart';
import 'package:music_app/utils/music_util.dart';
import 'package:music_app/widgets/circular_soft_button.dart';
import 'package:music_app/widgets/song_card.dart';

var audioManagerInstance = AudioManager.instance;
bool showVol = false;
PlayMode playMode = audioManagerInstance.playMode;
int curIndex = 0;
double slider = 0;

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late List<SongInfo> songList = <SongInfo>[];
  late SongInfo song;

  bool isPlaying = false;
  late String error;
  late Duration duration;
  late Duration position;

  @override
  void initState() {
    super.initState();
    setupAudio();
  }

  @override
  void dispose() {
    audioManagerInstance.release();
    super.dispose();
  }

  void setupAudio() {
    audioManagerInstance.intercepter = true;

    audioManagerInstance.onEvents((events, args) {
      switch(events) {
        case AudioManagerEvents.start:
          position = audioManagerInstance.position;
          duration = audioManagerInstance.duration;
          slider = 0;

          setState(() {});
          break;
        case AudioManagerEvents.ready:
          error = '';
          position = audioManagerInstance.position;
          duration = audioManagerInstance.duration;
          setState(() {});
          break;
        case AudioManagerEvents.seekComplete:
          position = audioManagerInstance.position;
          slider = position.inMilliseconds / duration.inMilliseconds;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = audioManagerInstance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          position = audioManagerInstance.position;
          slider = position.inMilliseconds / duration.inMilliseconds;
          setState(() {});
          audioManagerInstance.updateLrc(args["position"].toString());
          break;
        case AudioManagerEvents.error:
          error = args;
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {

                  },
                  child: CircularSoftButton(
                      icon: Icon(Icons.arrow_back_ios)
                  ),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: CircularSoftButton(
                      icon: Icon(Icons.view_headline)
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: FutureBuilder(
                future: FlutterAudioQuery().getSongs(
                    sortType: SongSortType.DEFAULT),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    songList = new List<SongInfo>.from(snapshot.data as List);
                    // check the song duration
                    songList.removeWhere((item) => int.parse(item.duration) < 1000);
                    song = songList[curIndex];
                    if (song.displayName.contains(".mp3")) {
                      return SongCard(song);
                    }
                    return SizedBox(
                      height: 0,
                    );
                  }

                  return Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Loading....",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 50),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: backgroundColor,
                    boxShadow: [
                      BoxShadow(color: whiteColor, offset: Offset(1, 4)),
                      BoxShadow(color: shadowColor, offset: Offset(-1, -4)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 10,
                          thumbColor: darkBlueColor,
                          overlayColor: darkBlueColor,
                          thumbShape: RoundSliderThumbShape(
                            disabledThumbRadius: 0,
                            enabledThumbRadius: 0,
                          ),
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 8,
                          ),
                          activeTrackColor: darkBlueColor,
                          inactiveTrackColor: backgroundColor,
                        ),
                        child: Slider(
                          value: slider,
                          onChanged: (value) {
                            setState(() {
                              slider = value;
                            });
                          },

                          onChangeEnd: (value) {
                            if (duration != null) {
                              Duration mSec = Duration(
                                  milliseconds:
                                  (duration.inMilliseconds * value).round());
                              audioManagerInstance.seekTo(mSec);
                            }
                          },
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                   MusicUtil.parseToMinutesSeconds(audioManagerInstance.position.inMilliseconds),
                    style: regulerTextStyle.copyWith(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    MusicUtil.parseToMinutesSeconds(audioManagerInstance.duration.inMilliseconds),
                    style:  regulerTextStyle.copyWith(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    if (songList!= null) {
                      if (songList != null) {
                        if (curIndex > 0) {
                          curIndex--;
                          audioManagerInstance.release();
                          audioManagerInstance.previous();
                          setState(() {});
                        }
                      }
                    }
                  },
                  child:  CircularSoftButton(
                    icon: Icon(Icons.skip_previous),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (song != null) {
                      (audioManagerInstance.isPlaying) ?
                       audioManagerInstance.toPause()
                      : audioManagerInstance
                          .start("file://${song.filePath}", song.title,
                          desc: song.displayName,
                          auto: true,
                          cover: (song.albumArtwork == null) ?
                          "assets/images/icon.png" :
                          song.albumArtwork)
                          .then((err) {
                      });
                    }
                  },
                  child:  CircularSoftButton(
                    icon: Icon(
                      audioManagerInstance.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 48,
                      color: darkBlueColor,
                    ),
                    radius: 48,
                  ),
                ),
                InkWell(
                  onTap: (){
                    if (songList != null) {
                      if (curIndex < songList.length -1) {
                        curIndex++;
                        audioManagerInstance.release();
                        audioManagerInstance.next();
                        setState(() {});
                      }
                    }
                  },
                  child: CircularSoftButton(
                    icon: Icon(Icons.skip_next),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:assets_app/pages/audio_files/playing_controls.dart';
import 'package:assets_app/pages/audio_files/positioned_seek_widget.dart';
import 'package:assets_app/pages/audio_files/song_selector.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AudioPageState();
  }
}

class AudioPageState extends State<AudioPage> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];

  final audios = <Audio>[
    Audio(
      'assets/audios/trendsetter-mood-maze-main-version.mp3',
    ),
    Audio(
      'assets/audios/seize-the-day-andrey-rossi-main-version.mp3',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      log('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      log('audioSessionId : $sessionId');
    }));

    openPlayer();
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const Text("Audios from assets",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 20)),
        const SizedBox(
          height: 20,
        ),
        Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            StreamBuilder<Playing?>(
                stream: _assetsAudioPlayer.current,
                builder: (context, playing) {
                  if (playing.data != null) {
                    final myAudio =
                        find(audios, playing.data!.audio.assetAudioPath);
                    log(playing.data!.audio.assetAudioPath);
                    //image
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: myAudio.metas.image?.path == null
                              ? Image.asset(
                                  "assets/images/flamingo.jpg",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                )
                              : myAudio.metas.image?.type == ImageType.network
                                  ? Image.network(
                                      myAudio.metas.image!.path,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    )
                                  : Image.asset(
                                      myAudio.metas.image!.path,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(myAudio.path.substring(14).toString()),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                // padding: const EdgeInsets.all(18),
                // margin: const EdgeInsets.all(18),
                onPressed: () {
                  AssetsAudioPlayer.playAndForget(Audio(
                      'assets/audios/seize-the-day-andrey-rossi-main-version.mp3'));
                },
                child: Icon(
                  Icons.add_alert,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
        _assetsAudioPlayer.builderCurrent(builder: (context, Playing? playing) {
          return Column(children: <Widget>[
            _assetsAudioPlayer.builderLoopMode(
              builder: (context, loopMode) {
                return PlayerBuilder.isPlaying(
                    player: _assetsAudioPlayer,
                    builder: (context, isPlaying) {
                      return PlayingControls(
                        loopMode: loopMode,
                        isPlaying: isPlaying,
                        isPlaylist: true,
                        onStop: () {
                          _assetsAudioPlayer.stop();
                        },
                        toggleLoop: () {
                          _assetsAudioPlayer.toggleLoop();
                        },
                        onPlay: () {
                          _assetsAudioPlayer.playOrPause();
                        },
                        onNext: () {
                          //_assetsAudioPlayer.forward(Duration(seconds: 10));
                          _assetsAudioPlayer.next(
                              keepLoopMode: true /*keepLoopMode: false*/);
                        },
                        onPrevious: () {
                          _assetsAudioPlayer.previous(/*keepLoopMode: false*/);
                        },
                      );
                    });
              },
            ),
            _assetsAudioPlayer.builderRealtimePlayingInfos(
                builder: (context, RealtimePlayingInfos? infos) {
              if (infos == null) {
                return const SizedBox();
              }
              log('infos: $infos');
              return Column(
                children: [
                  PositionSeekWidget(
                    currentPosition: infos.currentPosition,
                    duration: infos.duration,
                    seekTo: (to) {
                      _assetsAudioPlayer.seek(to);
                    },
                  ),

                  //Seek
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _assetsAudioPlayer
                              .seekBy(const Duration(seconds: -10));
                        },
                        child: const Text('-10'),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _assetsAudioPlayer
                              .seekBy(const Duration(seconds: 10));
                        },
                        child: const Text('+10'),
                      ),
                    ],
                  )
                ],
              );
            }),
          ]);
        }),
        const SizedBox(
          height: 20,
        ),
        _assetsAudioPlayer.builderCurrent(
            builder: (BuildContext context, Playing? playing) {
          return SongsSelector(
            audios: audios,
            onPlaylistSelected: (myAudios) {
              _assetsAudioPlayer.open(
                Playlist(audios: myAudios),
                showNotification: true,
                headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                audioFocusStrategy: const AudioFocusStrategy.request(
                    resumeAfterInterruption: true),
              );
            },
            onSelected: (myAudio) async {
              try {
                await _assetsAudioPlayer.open(
                  myAudio,
                  autoStart: true,
                  showNotification: true,
                  playInBackground: PlayInBackground.enabled,
                  audioFocusStrategy: const AudioFocusStrategy.request(
                      resumeAfterInterruption: true,
                      resumeOthersPlayersAfterDone: true),
                  headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                  notificationSettings: const NotificationSettings(
                      //seekBarEnabled: false,
                      //stopEnabled: true,
                      //customStopAction: (player){
                      //  player.stop();
                      //}
                      //prevEnabled: false,
                      //customNextAction: (player) {
                      //  print('next');
                      //}
                      //customStopIcon: AndroidResDrawable(name: 'ic_stop_custom'),
                      //customPauseIcon: AndroidResDrawable(name:'ic_pause_custom'),
                      //customPlayIcon: AndroidResDrawable(name:'ic_play_custom'),
                      ),
                );
              } catch (e) {
                log(e.toString());
              }
            },
            playing: playing,
          );
        }),
      ]),
    );
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
}

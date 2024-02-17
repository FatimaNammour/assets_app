import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  const PlayingControls({
    super.key,
    required this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
    this.onStop,
  });

  Widget _loopIcon(BuildContext context) {
    const iconSize = 34.0;
    if (loopMode == LoopMode.none) {
      return const Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.grey,
      );
    } else if (loopMode == LoopMode.playlist) {
      return const Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.black,
      );
    } else {
      //single
      return const Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.loop,
            size: iconSize,
            color: Colors.black,
          ),
          Center(
            child: Text(
              '1',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        GestureDetector(
          onTap: () {
            if (toggleLoop != null) toggleLoop!();
          },
          child: _loopIcon(context),
        ),
        const SizedBox(
          width: 5,
        ),
        ElevatedButton(
          onPressed: isPlaylist ? onPrevious : null,
          child: const Icon(Icons.arrow_back),
        ),
        const SizedBox(
          width: 5,
        ),
        ElevatedButton(
          onPressed: onPlay,
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 32,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        ElevatedButton(
          onPressed: isPlaylist ? onNext : null,
          child: const Icon(Icons.arrow_forward),
        ),
        const SizedBox(
          width: 45,
        ),
        // if (onStop != null)
        //   ElevatedButton(
        //     onPressed: onStop,
        //     child: const Icon(
        //       Icons.stop,
        //       size: 32,
        //     ),
        //   ),
      ],
    );
  }
}

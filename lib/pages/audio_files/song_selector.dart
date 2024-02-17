import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class SongsSelector extends StatelessWidget {
  final Playing? playing;
  final List<Audio> audios;
  final Function(Audio) onSelected;
  final Function(List<Audio>) onPlaylistSelected;

  const SongsSelector(
      {super.key,
      required this.playing,
      required this.audios,
      required this.onSelected,
      required this.onPlaylistSelected});

  Widget _image(Audio item) {
    if (item.metas.image == null) {
      return Image.asset(
        "assets/images/flamingo.jpg",
        height: 150,
        width: 150,
        fit: BoxFit.contain,
      );
    }

    return item.metas.image?.type == ImageType.network
        ? Image.network(
            item.metas.image!.path,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          )
        : Image.asset(
            item.metas.image!.path,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FractionallySizedBox(
          widthFactor: 0.8,
          child: ElevatedButton(
            onPressed: () {
              onPlaylistSelected(audios);
            },
            child: const Center(child: Text('All as playlist')),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, position) {
              final item = audios[position];
              final isPlaying = item.path == playing?.audio.assetAudioPath;
              return ListTile(
                  contentPadding: const EdgeInsets.all(2),
                  leading: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: _image(item),
                  ),
                  horizontalTitleGap: 0,
                  style: ListTileStyle.drawer,
                  title: Text(
                      // item.metas.title.toString(),
                      item.path.substring(14).toString(),
                      style: TextStyle(
                        color: isPlaying ? Colors.blue : Colors.black,
                      )),
                  onTap: () {
                    onSelected(item);
                  });
            },
            itemCount: audios.length,
          ),
        ),
      ],
    );
  }
}

import 'package:assets_app/pages/home_page.dart';
import 'package:assets_app/theme/theme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
      return true;
    });
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

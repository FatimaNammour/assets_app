import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late NotchBottomBarController _barController;

  @override
  void initState() {
    _barController = NotchBottomBarController(index: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedNotchBottomBar(
        bottomBarItems: [
          BottomBarItem(
              activeItem: SvgPicture.asset(
                  'assets/svg/image-plus-svgrepo-com.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.green, BlendMode.srcIn)),
              inActiveItem: SvgPicture.asset(
                  'assets/svg/image-plus-svgrepo-com.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
              itemLabel: "photo"),
          BottomBarItem(
              activeItem: SvgPicture.asset(
                  'assets/svg/video-plus-svgrepo-com.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.green, BlendMode.srcIn)),
              inActiveItem: SvgPicture.asset(
                  'assets/svg/video-plus-svgrepo-com.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
              itemLabel: "video"),
          BottomBarItem(
              activeItem: SvgPicture.asset(
                  'assets/svg/audio-square-svgrepo-com.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.green, BlendMode.srcIn)),
              inActiveItem: SvgPicture.asset(
                  'assets/svg/audio-square-svgrepo-com.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
              itemLabel: "audio"),
        ],
        notchBottomBarController: _barController,
        onTap: (int value) {},
        kIconSize: 25,
        kBottomRadius: 10,
      ),
      body: PageView(children: [Container(), Container(), Container()]),
    );
  }
}

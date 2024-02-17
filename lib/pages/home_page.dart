import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:assets_app/pages/images_assets.dart';
import 'package:assets_app/pages/videos_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late NotchBottomBarController _barController;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _barController = NotchBottomBarController(index: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const PhotoPage(),
    const VideoPage(),
    const PhotoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
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
          onTap: (int value) {
            _controller.jumpToPage(value);
          },
          kIconSize: 25,
          kBottomRadius: 10,
        ),
        body: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
      ),
    );
  }
}

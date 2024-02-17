import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return PhotoPageState();
  }
}

class PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Photos from assets",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 20)),
          Wrap(
            direction: Axis.horizontal,
            children: [
              Image.asset("assets/images/flamingo.jpg"),
              Image.asset(
                  "assets/images/academy-celebrate-celebration-267885.jpg"),
              Image.asset("assets/images/motor.jpg"),
              Image.asset("assets/images/accessory-blur-education-290043.jpg"),
              Image.asset(
                  "assets/images/blur-book-pages-environment-415061.jpg"),
            ],
          ),
        ],
      ),
    );
  }
}

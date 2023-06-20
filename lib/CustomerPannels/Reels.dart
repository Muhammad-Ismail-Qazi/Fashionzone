import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';
class Reels extends StatefulWidget {
  const Reels({super.key});

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  MyCustomAppBarComponent(),
      drawer: MyCustomDrawerComponent(),
      body: Placeholder(
        child: Text("This is AR"),
      ),
      bottomNavigationBar: MyCustomBottomNavigationBar(),
    );
  }
}

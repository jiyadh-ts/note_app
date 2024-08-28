import 'package:flutter/material.dart';

class Screentwo extends StatefulWidget {
  const Screentwo({super.key});

  @override
  State<Screentwo> createState() => _ScreentwoState();
}

class _ScreentwoState extends State<Screentwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FloatingActionButton(
            onPressed: () {
              _showModalBottomSheet(context);
            },
            child: Text("clickMe"),
          )
        ],
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Center(
            child: Text("This is a modal bottom sheet"),
          ),
        );
      },
    );
  }
}

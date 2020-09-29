import 'package:flutter/material.dart';
class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('Inbox', style: TextStyle(
            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.white,
      ),
    );
  }
}

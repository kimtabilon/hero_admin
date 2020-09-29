import 'package:flutter/material.dart';

class Inclusions extends StatefulWidget {
  @override
  _InclusionsState createState() => _InclusionsState();
}

class _InclusionsState extends State<Inclusions> {
  @override
  final _scrollController = ScrollController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('INCLUSIONS', style: TextStyle(
            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.white,
      ),
      body:
      SafeArea(
        child:
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Inclusions",style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.bold
              )),
              SizedBox(height: 5),
              Text("Please read the following instructions",style: TextStyle(
                color: Colors.grey,
              )),


              Expanded(
                child: Scrollbar(
                  controller: _scrollController, // <---- Here, the controller
                  isAlwaysShown: true, // <---- Required
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 20, 1, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hero Pabili is a concierge service wherein Heroes assist "
                              "clients in buying items ('pabili') such as "
                              "grocery items, wet goods and medicine.",style: TextStyle(
                              fontSize: 15
                          )),
                          SizedBox(height: 20),
                          Text("Guielines:",style: TextStyle(
                              fontSize: 15
                          )),
                          SizedBox(height: 20),
                          Text("1. Add the shop where the Hero will buy the items in the Where to buy section.",style: TextStyle(
                              fontSize: 15
                          )),
                          SizedBox(height: 20),
                          MaterialButton(
                            elevation: 0,
                            minWidth: double.maxFinite,
                            height: 60,
                            onPressed: () {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Inclusions()));



                            },
                            color: Color(0xFF13869f),
                            child: Text('ACCEPT',
                                style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold)),
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}

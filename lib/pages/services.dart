import 'package:flutter/material.dart';
import 'package:hero_admin/pages/inclusions.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('ADD A SERVICE', style: TextStyle(
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
              Text("Choose a Service",style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.bold
              )),
              SizedBox(height: 5),
              Text("Choose a service that you will be offering to clients.",style: TextStyle(
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
                        children: [
                          ListView(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[

                              Container(
                                  child: ListTile(
                                    contentPadding:  EdgeInsets.all(10),
                                    dense: true,
                                    leading: Material(
                                        type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFF13869f), width: 2.0),
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            //This keeps the splash effect within the circle
                                            borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
                                            child: Padding(
                                              padding:EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.child_care,
                                                size: 30.0,
                                                color: Color(0xFF13869f),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                    title: Text('Hero Express',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Lorem ipsum dolor sit amet.'),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,

                                      children: [

                                      ],
                                    ),
                                    onTap: () {

                                    },

                                  ),
                                  decoration:
                                  new BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ]
                                  )


                              ),
                              SizedBox(height: 10),
                              Container(
                                  child: ListTile(
                                    contentPadding:  EdgeInsets.all(10),
                                    dense: true,
                                    leading: Material(
                                        type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFF13869f), width: 2.0),
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            //This keeps the splash effect within the circle
                                            borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
                                            child: Padding(
                                              padding:EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.shopping_basket,
                                                size: 30.0,
                                                color: Color(0xFF13869f),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                    title: Text('Pabili',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Lorem ipsum dolor sit amet.'),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                      ],
                                    ),
                                    onTap: () {

                                    },
                                  ),
                                  decoration:
                                  new BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ]
                                  )
                              ),


                            ],
                          ),
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
                            child: Text('ADD THIS SERVICE',
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

import 'package:flutter/material.dart';
import 'package:hero_admin/pages/category.dart';
import 'package:hero_admin/pages/navigation.dart';
import 'package:hero_admin/pages/services.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('MY SERVICES', style: TextStyle(
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
                Text("My Services",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.bold
                )),
                SizedBox(height: 5),
                Text("List of services that you can offer",style: TextStyle(
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
                                      title: Text('Nanny Services',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Childcare'),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,

                                        children: [
                                          Text("Active",style: TextStyle(
                                              color: Color(0xFF93ca68)
                                          )),
                                          Text("For quotation",style: TextStyle(
                                              color: Color(0xFF93ca68)
                                          )),
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
                                      title: Text('General Handyman',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Handyman'),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Active",style: TextStyle(
                                              color: Color(0xFF93ca68)
                                          )),
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
                                                  Icons.book,
                                                  size: 30.0,
                                                  color: Color(0xFF13869f),
                                                ),
                                              ),
                                            ),
                                          )
                                      ),

                                      title: Text('Tutoring Service',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Childcare'),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Active",style: TextStyle(
                                              color: Color(0xFF93ca68)
                                          )),
                                        ],
                                      ),
                                      onTap: () {

                                      },
                                      //enabled: false,
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
                                    MaterialPageRoute(builder: (context) => Category()));



                              },
                              color: Color(0xFF13869f),
                              child: Text('ADD A SERVICE',
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

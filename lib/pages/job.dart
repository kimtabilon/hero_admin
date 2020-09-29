import 'package:flutter/material.dart';
import 'package:hero_admin/pages/job_details.dart';
class Job extends StatefulWidget {
  @override
  _JobState createState() => _JobState();
}

class _JobState extends State<Job> {
  @override
  final _scrollController = ScrollController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('JOBS', style: TextStyle(
            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.white,
      ),
      body:
        SafeArea(
          child:
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        minWidth: 150,
                        color: Color(0xFF93ca68),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xFF93ca68))
                        ),
                        onPressed: (){},
                        child: Text("CURRENT JOBS", style: TextStyle(
                          color: Colors.white,fontSize: 12.0,
                        ))),
                    SizedBox(width: 10),
                    FlatButton(
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)
                        ),
                        onPressed: (){},
                        child: Text("COMPLETED JOBS", style: TextStyle(
                          color: Colors.black,fontSize: 12.0,
                        ))),
                  ],
                ),


                SizedBox(height: 10),
                Divider(thickness:1,color: Colors.grey),

                Expanded(
                  child: Scrollbar(
                    controller: _scrollController, // <---- Here, the controller
                    isAlwaysShown: true, // <---- Required
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
                                        Text('Pasay City'),
                                        Text('05/03/2020 12:10 PM'),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Pending"),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => JobDetails()));

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
                                        Text('Pasay City'),
                                        Text('05/03/2020 12:10 PM'),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Pending"),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => JobDetails()));
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
                                                Icons.directions_run,
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
                                        Text('Pasay City'),
                                        Text('05/03/2020 12:10 PM'),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Pending"),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => JobDetails()));
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
                                                Icons.child_care,
                                                size: 30.0,
                                                color: Color(0xFF13869f),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    title: Text('Nanny Service',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Pasay City'),
                                        Text('05/03/2020 12:10 PM'),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Pending"),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => JobDetails()));
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        )
    );

  }
}




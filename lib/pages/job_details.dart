import 'package:flutter/material.dart';
class JobDetails extends StatefulWidget {
  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  final _scrollController = ScrollController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('PABILI 04/25/2020 10:23 AM', style: TextStyle(
            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.white,
      ),

      body:
      SafeArea(
        child: Scrollbar(
          controller: _scrollController, // <---- Here, the controller
          isAlwaysShown: true, // <---- Required
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Ink(
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
                          ),
                          SizedBox(width: 10),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Pabili",style: TextStyle(
                                   fontSize: 13,fontWeight: FontWeight.bold
                               )),
                               Text("Pasay City",style: TextStyle(
                                   fontSize: 12,color: Colors.grey[600]
                               )),
                               Text("04/25/2020 10:23 AM",style: TextStyle(
                                   fontSize: 12,color: Colors.grey[600]
                               )),
                             ],
                           )


                        ],

                      ),


                      Text("Completed",style: TextStyle(
                          color: Color(0xFF93ca68)
                      )),
                    ],

                  ),


                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          color: Color(0xFF13869f),
                          onPressed: (){},
                          child: Text("GET DIRECTIONS", style: TextStyle(
                            color: Colors.white,fontSize: 12.0,
                          ))),
                      SizedBox(width: 15),
                      FlatButton(
                          color: Color(0xFF13869f),
                          onPressed: (){

                          },
                          child: Text("CHAT WITH CLIENT", style: TextStyle(
                            color: Colors.white,fontSize: 12.0,
                          ))),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                      ),
                      Text("CUSTOMER NAME", style: TextStyle(
                          fontSize: 12,color: Color(0xFF13869f),fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 5),
                      Text("john.doe@gmail.com"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                      ),
                      Text("ADDRESS", style: TextStyle(
                          fontSize: 12,color: Color(0xFF13869f),fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 5),
                      Text("john.doe@gmail.com"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                      ),
                      Text("WHAT TO BUY", style: TextStyle(
                          fontSize: 12,color: Color(0xFF13869f),fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 5),
                      Text("john.doe@gmail.com"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                      ),
                      Text("WHERE TO BUY", style: TextStyle(
                          fontSize: 12,color: Color(0xFF13869f),fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 5),
                      Text("john.doe@gmail.com"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                      ),
                      Text("DELIVERY DATE", style: TextStyle(
                          fontSize: 12,color: Color(0xFF13869f),fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 5),
                      Text("john.doe@gmail.com"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}

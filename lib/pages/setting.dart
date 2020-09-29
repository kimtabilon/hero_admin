import 'package:flutter/material.dart';
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  final _scrollController = ScrollController();
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('SETTINGS', style: TextStyle(
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Switch Offline",
                          style: TextStyle( fontSize: 17,fontWeight: FontWeight.bold)),
                      Switch(
                        value: isSwitched,
                        onChanged: (value){
                          setState(() {
                            isSwitched=value;
                            print(isSwitched);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                        ),
                    ],
                  ),
                  Container(
                    width: 250,
                    child:
                    Text("Para hindi makatanggap ng booking, o para maging invisible sa system,"
                        "i-swipe papuntang kanan ang switch upang ma-activate.",
                        style: TextStyle( fontSize: 14,color: Colors.grey)),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Preferred Location",
                          style: TextStyle( fontSize: 17,fontWeight: FontWeight.bold)),
                      Text("edit"),
                    ],
                  ),
                  Container(
                    width: 250,
                    child:
                    Text("Para makatanggap ng booking sa piling lugar,"
                        "pindutin ang Preferred Location at i-check lamang ang mga lugar"
                        "na nais mong makuhanan ng booking.",
                        style: TextStyle( fontSize: 14,color: Colors.grey)),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Auto Confirm Job",
                          style: TextStyle( fontSize: 17,fontWeight: FontWeight.bold)),
                      Switch(
                        value: isSwitched,
                        onChanged: (value){
                          setState(() {
                            isSwitched=value;
                            print(isSwitched);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                  Container(
                    width: 250,
                    child:
                    Text("Upang maunang makapag confirm ng booking, "
                        "i-swipe papuntang kanan ang switch upang ma-activate. "
                        "Gumagana lamang ito sa mga time-based na trabaho tulad ng Housekeeping at Child Services",
                        style: TextStyle( fontSize: 14,color: Colors.grey)),
                  ),

                  SizedBox(height: 10),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Edit Account",
                          style: TextStyle( fontSize: 17,fontWeight: FontWeight.bold)),
                      Text("REQUEST"),
                    ],
                  ),
                  Container(
                    width: 250,
                    child:
                    Text("Kung may nais baguhin sa iyong profile tab,"
                        "pindutin ito para magsend ng request sa admin at mai-unlock ang "
                        "iyong profile tab",
                        style: TextStyle( fontSize: 14,color: Colors.grey)),
                  ),

                  SizedBox(height: 10),
                  Divider(thickness:1,color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Manage Schedule",
                          style: TextStyle( fontSize: 17,fontWeight: FontWeight.bold)),
                      Text("edit"),
                    ],
                  ),
                  Container(
                    width: 250,
                    child:
                    Text("Pindutin ang Manage Schedule kung hindi nais makatanggap "
                        "ng bookung sa mga piling petsa o araw. Tandaan: Makakatanggap "
                        "pa rin ang Hero ng Bookung maliban lamang sa araw na napili niyang mag-off",
                        style: TextStyle( fontSize: 14,color: Colors.grey)),
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

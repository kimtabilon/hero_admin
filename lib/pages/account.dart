import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hero_admin/pages/edit.dart';
import 'package:hero_admin/pages/review.dart';
import 'package:hero_admin/pages/setting.dart';
import 'package:hero_admin/pages/navigation.dart';
import 'package:hero_admin/widgets/provider_widget.dart';
import 'package:hero_admin/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import 'package:rxdart/rxdart.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}



class _AccountState extends State<Account> {

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
        title: const Text('MY ACCOUNT', style: TextStyle(
            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.white,
      ),

      body:
      StreamBuilder(
        stream: getUserDataSnapshots(context),
        builder: (context,AsyncSnapshot<List<UserData>>  profileSnapshot) {

              if (profileSnapshot.hasError)
                return const SpinKitDoubleBounce(
                    color: Color(0xFF93ca68),
                    size: 50.0);
                switch (profileSnapshot.connectionState) {
                    case ConnectionState.waiting:
                        return const SpinKitDoubleBounce(
                      color: Color(0xFF93ca68),
                      size: 50.0);
                    default:
                        return new ListView(
                            children: profileSnapshot.data.map((UserData user) {
                              return new SafeArea(
                                child:  Scrollbar(
                                          controller: _scrollController, // <---- Here, the controller
                                          isAlwaysShown: true, // <---- Required
                                              child: SingleChildScrollView(
                                                controller: _scrollController,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(18.0),
                                                      child: Column(
                                                        children: [
                                                             CircleAvatar(
                                                               backgroundColor: Colors.brown.shade800,
                                                               child:
                                                                ClipOval(
                                                                  child:
                                                                  Image.network(user.photo,width: 90,
                                                                       height: 90,fit: BoxFit.fill),
                                                                    ),
                                                               radius: 25,
                                                             ),

                                                            SizedBox(height: 10),

                                                            Text(user.first_name +" "+ user.last_name
                                                                ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),

                                                            SizedBox(height: 10),

                                                             Text(user.city +","+ user.province
                                                                 ,style: TextStyle(fontSize: 12)),

                                                            SizedBox(height: 10),

                                                                   Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        FlatButton(
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(0.0),
                                                                                side: BorderSide(color: Colors.black)
                                                                            ),
                                                                            onPressed: (){
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) => Edit()));

                                                                            },
                                                                            child: Text("EDIT PROFILE", style: TextStyle(
                                                                                color: Colors.black,fontSize: 12.0,
                                                                            ))),
                                                                        SizedBox(width: 15),
                                                                        FlatButton(
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(0.0),
                                                                                side: BorderSide(color: Colors.black)
                                                                            ),
                                                                            onPressed: (){
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) => Setting()));

                                                                            },
                                                                            child: Text("EDIT SETTINGS", style: TextStyle(
                                                                              color: Colors.black,fontSize: 12.0,
                                                                            ))),
                                                                      ],
                                                                   ),

                                                                   FlatButton(
                                                                       color: Color(0xFF13869f),
                                                                        minWidth: 240,
                                                                       onPressed: (){
                                                                         Navigator.push(
                                                                             context,
                                                                             MaterialPageRoute(builder: (context) => Review()));
                                                                       },
                                                                       child: Text("VIEW MY REVIEWS", style: TextStyle(
                                                                         color: Colors.white
                                                                       ))),
                                                                       FlatButton(
                                                                           minWidth: 240,
                                                                           shape: RoundedRectangleBorder(
                                                                               borderRadius: BorderRadius.circular(0.0),
                                                                               side: BorderSide(color: Colors.black)
                                                                           ),
                                                                           onPressed: ()async{
                                                                             try{
                                                                               AuthService auth = Provider.of(context).auth;
                                                                               await auth.signOut();
                                                                               Navigator.of(context).pushReplacementNamed('/home');
                                                                             }catch(e){

                                                                             }
                                                                           },
                                                                           child: Text("LOG OUT", style: TextStyle(
                                                                               color: Colors.black
                                                                           ))),
                                                                       SizedBox(height: 20),
                                                                       Row(
                                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                                         children: [
                                                                           Column(
                                                                             children: [
                                                                               Text("0", style: TextStyle(
                                                                                   color: Colors.red,
                                                                                 fontSize: 25
                                                                               )),
                                                                               SizedBox(height: 10),
                                                                               Text("JOBS"),
                                                                               Text("PENDING"),
                                                                             ],
                                                                           ),
                                                                           Container(width:50,height: 50, child: VerticalDivider(color: Colors.grey)),
                                                                           Column(
                                                                             children: [
                                                                               Text("0", style: TextStyle(
                                                                                   fontSize: 25
                                                                               )),
                                                                               SizedBox(height: 10),
                                                                               Text("JOBS"),
                                                                               Text("COMPLETED"),
                                                                             ],
                                                                           ),
                                                                           Container(width:50,height: 50, child: VerticalDivider(color: Colors.grey)),
                                                                           Column(
                                                                             children: [
                                                                               Text("0", style: TextStyle(
                                                                                   fontSize: 25
                                                                               )),
                                                                               SizedBox(height: 10),
                                                                               Text("REVIEWS"),
                                                                             ],
                                                                           ),
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
                                                                           Text("EMAIL", style: TextStyle(
                                                                               fontSize: 12,color: Colors.grey[700]
                                                                           )),
                                                                           SizedBox(height: 5),
                                                                           Text(user.email),
                                                                         ],
                                                                       ),
                                                                       SizedBox(height: 20),
                                                                       Divider(thickness:1,color: Colors.grey),
                                                                       SizedBox(height: 20),

                                                                       // Column(
                                                                       //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                       //   children: [
                                                                       //     Align(
                                                                       //       alignment: Alignment.centerLeft,
                                                                       //     ),
                                                                       //     Text("EDUCATIONAL BACKGROUND", style: TextStyle(
                                                                       //         fontSize: 12,color: Colors.grey[700]
                                                                       //     )),
                                                                       //     SizedBox(height: 5),
                                                                       //     Text(user.educational_background),
                                                                       //     SizedBox(height: 25),
                                                                       //     Text("CERTIFICATIONS", style: TextStyle(
                                                                       //         fontSize: 12,color: Colors.grey[700]
                                                                       //     )),
                                                                       //     SizedBox(height: 5),
                                                                       //     Text(user.certification),
                                                                       //     SizedBox(height: 25),
                                                                       //     Text("WORK EXPERIENCE", style: TextStyle(
                                                                       //         fontSize: 12,color: Colors.grey[700]
                                                                       //     )),
                                                                       //     SizedBox(height: 5),
                                                                       //     Text(user.work_experience),
                                                                       //   ],
                                                                       // ),

                                                        ],
                                                      ),
                                                    ),
                                              ),





                                ),
                              );
                            }).toList()
                        );

            }
        }
      ),

    );
  }
}

class UserData {
  final email;
  final photo;
  final first_name;
  final last_name;
  final province;
  final city;
  const UserData(this.email,this.photo,this.first_name, this.last_name,this.province,this.city);
}


Stream<List<UserData>> getUserDataSnapshots(BuildContext context) async* {
  final uid = await Provider.of(context).auth.getCurrentUID();
  //yield* FirebaseFirestore.instance.collection('profile').where('profile_id', isEqualTo: uid).snapshots();

  var profile = FirebaseFirestore.instance.collection('profile').where('profile_id', isEqualTo: uid).snapshots();
  var data = List<UserData>();
  await for (var profileSnapshot in profile) {
    for (var profileDoc in profileSnapshot.docs) {
      var ProfileData;
      var emailSnapshot = await FirebaseFirestore.instance.collection("client").where('profile_id', isEqualTo: uid).get();
      var addressSnapshot = await FirebaseFirestore.instance.collection("address").where('profile_id', isEqualTo: uid).get();
      ProfileData = UserData(
          emailSnapshot.docs[0].get('email'),
          profileSnapshot.docs[0].get('photo'),
          profileSnapshot.docs[0].get('first_name'),
          profileSnapshot.docs[0].get('last_name'),
          addressSnapshot.docs[0].get('province'),
          addressSnapshot.docs[0].get('city'),
          );

      data.add(ProfileData);
    }

    yield data;
  }


}



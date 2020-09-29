import 'package:flutter/material.dart';
import 'package:hero_admin/pages/login.dart';
import 'package:hero_admin/pages/signup.dart';

class Home extends StatefulWidget {
  @override

  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF19899c),
      body:SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(colors: [const Color(0xFF19899c), const Color(0xFF8cc66b)],
            begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            )
              // image: DecorationImage(
              //     image: AssetImage('assets/day.png'),
              //     fit: BoxFit.cover
              // )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png',
                  width: 600.0,
                  height: 400.0,)
                ,
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()));



                  },
                  color: Color(0xFF13869f),
                  child: Text('LOG-IN',
                      style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  color: Colors.white,
                  child: Text('GUMAWA NG ACCOUNT',
                      style: TextStyle(color: Color(0xFF13869f), fontSize: 18,fontWeight: FontWeight.bold)),
                  textColor: Color(0xFF13869f),
                ),

              ],
            ),
          ),





        ),

      ) ,
    );
  }
}


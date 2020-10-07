import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hero_admin/pages/forgotpassword.dart';
import 'package:hero_admin/pages/navigation.dart';
import 'package:hero_admin/widgets/provider_widget.dart';
import 'package:hero_admin/services/auth_service.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {

  @override

  bool _isButtonDisabled = false;
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {

    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: Color(0xFF8cc66b),
        body: SafeArea(
          child: SingleChildScrollView(
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
                child: Form(
                  key: _formKey,
                  child: Column(

                    children: [
                      Image.asset('assets/logo.png',
                        width: 350.0,
                        height: 390.0,)
                      ,

                      _buildTextField(
                          nameController, 'Email'),
                      SizedBox(height: 10),
                      _buildPasswordField(passwordController, 'Password'),
                      SizedBox(height: 10),
                      MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 60,
                        onPressed: _isButtonDisabled ? (){} : () async{


                          if (_formKey.currentState.validate()) {

                            setState(() => _isButtonDisabled = true);
                            User firebaseUser;
                            String errorMessage;

                            try{
                              final auth = Provider.of(context).auth;
                              EasyLoading.show(status: 'loading...');
                              var uid = await auth.signInWithEmailAndPassword(nameController.text.trim(), passwordController.text);


                              final exist = await FirebaseFirestore.instance
                                  .collection('admin')
                                  .doc(uid)
                                  .get();
                              if(exist == null){
                                errorMessage = "No Admin User";
                              }


                            } catch (error) {
                              errorMessage = error.code;
                              print(errorMessage);
                            }

                            EasyLoading.dismiss();
                            setState(() => _isButtonDisabled = false);
                            if (errorMessage != null) {
                              String alertMessage;
                              if(errorMessage == 'user-not-found'){
                                alertMessage = 'User not found.';
                              }else{
                                alertMessage = 'Wrong Email or Password.Please try again.';
                              }

                              nameController.text = "";
                              passwordController.text = "";
                              _awesomeDialogError(
                                  alertMessage,
                                  context
                              );

                            }else{





                              nameController.text = "";
                              passwordController.text = "";
                              _awesomeDialogSucces(
                                  'Login Successful.',
                                  '/navigation',
                                  context
                              );

                            }

                          }



                        }
                        ,
                        color: Color(0xFF13869f),
                        child: Text('LOG-IN',
                            style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold)),
                        textColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                              child: new InkWell(
                                child: new Text('Forgot Password?',
                                    style: TextStyle(color: Colors.white,fontSize: 15, fontStyle: FontStyle.italic)),
                                onTap: _isButtonDisabled ? null : (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgotPassword()));

                                },
                              ),
                            ),

                          ],
                        ),
                      ),



                    ],
                  ),
                ),
              ),





            ),
          ),

        ) ,
      ),
    );
  }
}


_buildTextField(
    TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      color: Color(0xFFffffff).withOpacity(0.4)),
    child: TextFormField(
        validator: (value) {

        if (value.isEmpty) {
          return 'This field is required.';
        }else if(!isEmail(value)){
          return 'Invalid email address.';
        }
        return null;
      },
      controller: controller,
      style: TextStyle(color: Colors.white,fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),

          // prefix: Icon(icon),
          border: InputBorder.none),
    ),
  );
}

_buildPasswordField(
    TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        color: Color(0xFFffffff).withOpacity(0.4)),
    child: TextFormField(
      validator: (value) {

        if (value.isEmpty) {
          return 'This field is required.';
        }
        return null;
      },
      obscureText: true,
      controller: controller,
      style: TextStyle(color: Colors.white,fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          // prefix: Icon(icon),
          border: InputBorder.none),
    ),
  );
}

_awesomeDialogSucces(String content,String Redirect,BuildContext context){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      title: 'Success',
      desc: content,
      btnOkOnPress: () {
        Navigator.of(context).pushReplacementNamed(Redirect);
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: () {
        debugPrint('Dialog Dissmiss from callback');
      }).show();
}

_awesomeDialogError(String content,BuildContext context){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.ERROR,
      title: 'Error',
      desc: content,
      btnOkOnPress: () {
      },
      btnOkIcon: Icons.cancel,
      onDissmissCallback: () {
        debugPrint('Dialog Dissmiss from callback');
      }).show();
}

bool isEmail(String em) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}


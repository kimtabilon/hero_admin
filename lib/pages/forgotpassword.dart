import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hero_admin/pages/login.dart';
import 'package:hero_admin/widgets/provider_widget.dart';

final TextEditingController nameController = TextEditingController();
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

bool _isButtonDisabled = false;
final _formKey = GlobalKey<FormState>();
class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          title: const Text('FORGOT PASSWORD', style: TextStyle(
              color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
          )),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Reset Password",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
                  SizedBox(height: 10),
                  Text("If you need help resetting your password, we can help by sending you a link to reset it.",style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  )),
                  SizedBox(height: 30),
                  _buildTextField(nameController, 'Email'),
                  SizedBox(height: 15),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 60,
                    onPressed: _isButtonDisabled ? (){} : () async {

                      if (_formKey.currentState.validate()) {

                        setState(() => _isButtonDisabled = true);
                        EasyLoading.show(status: 'loading...');


                        try {
                          String _email = nameController.text.trim();
                          final auth = Provider.of(context).auth;
                          await auth.sendPasswordResetEmail(nameController.text.trim());
                          // User user = await auth.createUserWithEmailAndPassword(emailController.text.trim(), passController.text);
                          //
                          // if(user != null){
                          //   EasyLoading.dismiss();
                          //   nameController.text = "";
                          //
                            EasyLoading.dismiss();
                            nameController.text = "";
                            _awesomeDialogSucces(
                                'A password reset link has been sent to $_email.',
                                '/login',
                                context);
                          // }
                        } catch (e) {
                          nameController.text = "";
                          EasyLoading.dismiss();
                          String alertMessage;
                          if(e.code == 'user-not-found'){
                            alertMessage = 'User not found.';
                          }
                          _formKey.currentState.reset();
                          _awesomeDialogError(
                              alertMessage,
                              context
                          );
                        }

                        setState(() => _isButtonDisabled = false);




                      }




                    },
                    color: Color(0xFF13869f),
                    child: Text('Submit',
                        style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold)),
                    textColor: Colors.white,
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



_buildTextField(
    TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
      style: TextStyle(color: Colors.black,fontSize: 15),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.blue, fontSize:15,),
        // prefix: Icon(icon),
      ),
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
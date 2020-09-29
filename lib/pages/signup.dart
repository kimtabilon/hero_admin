import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hero_admin/pages/login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hero_admin/widgets/provider_widget.dart';
import 'package:hero_admin/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_strength/password_strength.dart';
class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}
final TextEditingController fnameController = TextEditingController();
final TextEditingController lnameController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController conpassController = TextEditingController();

class _SignUpState extends State<SignUp> {
  final db = FirebaseFirestore.instance;
  @override



  bool _isButtonDisabled = false;
  final formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {

    return FlutterEasyLoading(
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          title: const Text('SIGN UP', style: TextStyle(
              color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
          )),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gumawa ng Account",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                  )),
                  SizedBox(height: 10),
                  Text("Upang makakuha ng trabaho sa HERO APP,",style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  )),
                  Text("kinakailangan namin ang iyong impormasyon.",style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  )),
                  SizedBox(height: 30),
                  _buildTextField(fnameController, 'First Name'),
                  SizedBox(height: 5),
                  _buildTextField(lnameController, 'Last Name'),
                  SizedBox(height: 5),
                  _buildNumberField(mobileController, 'Mobile Number (+63 or 09)'),
                  SizedBox(height: 5),
                  _buildEmailField(emailController, 'Email Address'),
                  SizedBox(height: 5),
                  _buildPasswordField(passController, 'Password'),
                  SizedBox(height: 5),
                  _buildPasswordField(conpassController, 'Confirm Password'),
                  SizedBox(height: 15),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 60,
                    onPressed: _isButtonDisabled ? (){} : () async {

                    if (formKey.currentState.validate()) {

                      setState(() => _isButtonDisabled = true);
                      EasyLoading.show(status: 'loading...');
                      String resultexist;

                      try {

                        final auth = Provider.of(context).auth;

                            final usercheck = await auth.doesNameAlreadyExist(
                                emailController.text,
                                fnameController.text,
                                lnameController.text,
                                mobileController.text);
                            if(usercheck != null){
                              resultexist = usercheck;
                            }


                        // final  result = FirebaseFirestore.instance.collection('userData');
                        //
                        // await result.get().then((snapshot) async{
                        //
                        //   for (int i = 0; i < snapshot.docs.length; i++) {
                        //     var a = snapshot.docs[i];
                        //     final usercheck = await auth.doesNameAlreadyExist(a.id,
                        //         emailController.text,
                        //         fnameController.text,
                        //         lnameController.text,
                        //         mobileController.text);
                        //     if(usercheck != null){
                        //       resultexist = usercheck;
                        //     }
                        //   }
                        //
                        //
                        // });



                        if(resultexist == null){

                          final uid = await auth.createUserWithEmailAndPassword(emailController.text.trim(), passController.text);

                          if(uid != null){
                            DateTime currentPhoneDate = DateTime.now();
                            await db.collection('client').add(
                                {
                                  'profile_id': uid,
                                  'email': emailController.text.trim(),
                                  'password': passController.text,
                                  'status': 'activated',
                                  'created_at': currentPhoneDate,
                                  'updated_at': '',
                                }
                            );
                            await db.collection('contact').add(
                                {
                                  'profile_id': uid,
                                  'type': 'mobile',
                                  'value': mobileController.text,
                                }
                            );
                            await db.collection('address').add(
                                {
                                  'profile_id': uid,
                                  'province': '',
                                  'city': '',
                                  'barangay': '',
                                  'street': '',
                                  'zip': '',
                                }
                            );
                            await db.collection('profile').add(
                                {
                                  'profile_id': uid,
                                  'first_name': fnameController.text,
                                  'last_name': lnameController.text,
                                  'gender': "None",
                                  'birthday': "None",
                                  'photo' : "https://firebasestorage.googleapis.com/v0/b/hero-app-96074.appspot.com/o/profile%2Fdefault.jpg?alt=media&token=2349fd41-698c-4cbf-ac86-c466beaabc7f",
                                }
                            );
                            await auth.signOut();
                            EasyLoading.dismiss();
                            fnameController.text = "";
                            lnameController.text = "";
                            mobileController.text = "";
                            emailController.text = "";
                            passController.text = "";
                            conpassController.text = "";
                            _awesomeDialogSucces(
                                'Congratulations, your account has been successfully created.',
                                Login(),
                                context
                            );
                          }

                        }else{
                          await auth.signOut();
                          EasyLoading.dismiss();
                          _awesomeDialogError(
                              resultexist,
                              context
                          );
                        }


                      } catch (e) {
                        print(e);
                        EasyLoading.dismiss();
                        String alertMessage;
                        if(e.code == 'email-already-in-use'){
                          alertMessage = 'Email already in use.';
                        }
                        formKey.currentState.reset();
                        _awesomeDialogError(
                            alertMessage,
                            context
                        );
                      }

                      setState(() => _isButtonDisabled = false);




                    }




                   },
                    color: Color(0xFF13869f),
                    child: Text('DONE',
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

enum Gender { Male, Female }

class SignupPage2 extends StatefulWidget {
  @override
  _SignupPage2State createState() => _SignupPage2State();
}

final TextEditingController streetController = TextEditingController();
final TextEditingController provinceController = TextEditingController();
final TextEditingController cityController = TextEditingController();
final TextEditingController zipController = TextEditingController();

class _SignupPage2State extends State<SignupPage2> {



  Gender _gender = Gender.Male;

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('SIGN UP - STEP 2 OF 2', style: TextStyle(
            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gumawa ng Account",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
              SizedBox(height: 10),
              Text("Upang makakuha ng trabaho sa HERO APP,",style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              )),
              Text("kinakailangan namin ang iyong impormasyon.",style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              )),
              SizedBox(height: 30),
              Text("BIRTHDAY",style: TextStyle(
                fontSize: 13,
                color: Colors.blue[700],
              )),
              SizedBox(height: 5),
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
              
              SizedBox(height: 5),
              Text("SEX",style: TextStyle(
                fontSize: 13,
                color: Colors.blue[700],
              )),

              ListTile(
                title: const Text('Male'),
                leading: Radio(
                  value: Gender.Male,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Female'),
                leading: Radio(
                  value: Gender.Female,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              Text("Address",style: TextStyle(
                fontSize: 13,
                color: Colors.blue[700],
              )),
              SizedBox(height: 5),
              _buildTextField(streetController, 'Street/House No/Unit No/Barangay'),
              SizedBox(height: 5),
              _buildTextField(provinceController, 'Province'),
              SizedBox(height: 5),
              _buildTextField(cityController, 'City'),
              SizedBox(height: 5),
              _buildTextField(zipController, 'Zip Code'),
              SizedBox(height: 15),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 60,
                onPressed: () {
                },
                color: Color(0xFF13869f),
                child: Text('DONE',
                    style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold)),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



_awesomeDialogSucces(String content,Widget Redirect,BuildContext context){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      title: 'Success',
      desc: content,
      btnOkOnPress: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: () {
        debugPrint('Dialog Dissmiss from callback');
      }).show();
}



_buildTextField(
    TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    child: TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is required.';
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

bool isEmail(String em) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

_buildEmailField(
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


_buildNumberField(
    TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    child: TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {

        String patttern = r'(^(09|\+639)\d{9}$)';
        RegExp regExp = new RegExp(patttern);
        if (value.isEmpty) {
          return 'This field is required.';
        }else if (!regExp.hasMatch(value)) {
          return 'Please enter valid mobile number';
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




_buildPasswordField(
    TextEditingController controller, String labelText) {

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    child: TextFormField(
      validator: (value) {
        double strength = estimatePasswordStrength(value);
        if (value.isEmpty) {
          return 'This field is required.';
        }else if(value.trim().length < 6) {
          return 'Password should be at least 6 characters.';
        }else if (strength < 0.5) {
          return 'This password is weak.';
        }else if(passController.text.trim() != conpassController.text.trim()){
          return "Those passwords didn't match. Try again.";
        }
        return null;
      },
      obscureText: true,
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


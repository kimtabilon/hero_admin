import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hero_admin/pages/account.dart';
import 'package:hero_admin/pages/navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hero_admin/widgets/provider_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:password_strength/password_strength.dart';
import 'package:philippines/city.dart';
import 'package:philippines/philippines.dart';
import 'package:philippines/province.dart';
import 'package:path/path.dart' as Path;

final _formKey = GlobalKey<FormState>();

final TextEditingController nameController = TextEditingController();
final TextEditingController lnameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController PasswordController = TextEditingController();
final TextEditingController ConPasswordController = TextEditingController();
final TextEditingController OldPasswordController = TextEditingController();

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}



class _EditState extends State<Edit>{
  @override

  final db = FirebaseFirestore.instance;

  DateTime selectedDate = DateTime.now();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    var pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
    String filName = Path.basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filName);
    StorageUploadTask uploadTask=firebaseStorageRef.child('Users/').putFile(_image);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();

    final uid = await Provider.of(context).auth.getCurrentUID();
    var profileSnapshot = await FirebaseFirestore.instance.collection("profile").where('profile_id', isEqualTo: uid).get();
    await db.collection('profile').doc(profileSnapshot.docs[0].id)
        .set(
        {
          'photo': dowurl.toString(),
        })
        .then((value) {
      _awesomeDialogResult(
          "Success", "Info Updated Successfully", context,
          DialogType.SUCCES, Icons.check_circle);
    }
    )
        .catchError((error) {
      _awesomeDialogResult(
          "Error", error, context, DialogType.ERROR,
          Icons.cancel);
    }
    );

    setState(() {});
  }


  Future _awesomeDialogEdit(String jsonName,String title,TextEditingController inputController) async {

    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      dismissOnTouchOutside: false,
      keyboardAware: true,
      btnCancelOnPress: () {
        setState(() => _isButtonDisabled = false);
      },
      btnOk:
      FlatButton(
          color: Color(0xFF13869f),
          minWidth: 200,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
          ),
          onPressed: () async {

            if (_formKey.currentState.validate()) {
              setState(() => _isButtonDisabled = false);
              final uid = await Provider.of(context).auth.getCurrentUID();
              var addressSnapshot = await FirebaseFirestore.instance.collection("address").where('profile_id', isEqualTo: uid).get();

              if(title == "Password"){

                User firebaseUser;
                String errorMessage;

                try{
                        final auth = Provider.of(context).auth;
                        User uidResult = await auth.signInWithEmailAndPassword(emailController.text.trim(), OldPasswordController.text);


                        uidResult.updatePassword(PasswordController.text.trim()).then((_) async {

                          var heroSnapshot = await FirebaseFirestore.instance.collection("admin").doc(uid).get();
                          await db.collection('admin').doc(heroSnapshot.id)
                              .update(
                              {
                                'password': PasswordController.text.trim(),
                              });
                          OldPasswordController.text = "";
                          PasswordController.text = "";
                          ConPasswordController.text = "";
                            _awesomeDialogResult(
                                "Success", "Info Updated Successfully", context,
                                DialogType.SUCCES, Icons.check_circle);
                          }).catchError((error){
                            _awesomeDialogResult(
                                "Error", error, context, DialogType.ERROR,
                                Icons.cancel);
                          });




                } catch (error) {
                  errorMessage = error.code;
                  print(errorMessage);
                }

                if (errorMessage != null) {
                  String alertMessage;
                  if(errorMessage == 'user-not-found'){
                    alertMessage = 'User not found.';
                  }else{
                    alertMessage = 'Wrong Password.Please try again.';
                  }

                  OldPasswordController.text = "";
                  PasswordController.text = "";
                  ConPasswordController.text = "";
                  _awesomeDialogError(
                      alertMessage,
                      context
                  );

                }

              }else {
                List<String> JNames = ['first_name', 'last_name', 'birthday', 'gender'];
                var collectionName;
                var saveSnapshot;
                  if(JNames.contains(jsonName)){
                    collectionName = 'profile';
                    saveSnapshot = await FirebaseFirestore.instance.collection("profile").where('profile_id', isEqualTo: uid).get();
                  }

                  await db.collection(collectionName).doc(saveSnapshot.docs[0].id)
                      .update({
                        jsonName: inputController.text,
                      })
                      .then((value){
                      _awesomeDialogResult(
                          "Success", "Info Updated Successfully", context,
                          DialogType.SUCCES, Icons.check_circle);
                      }
                  )
                      .catchError((error){
                      _awesomeDialogResult(
                          "Error", error, context, DialogType.ERROR,
                          Icons.cancel);
                      }
                  );
              }
            }
            setState(() {});
          },
          child: Center(
            child: Text("Confirm", style: TextStyle(
                color: Colors.white
            )),
          ))
      ,

      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              _buildTextField(
                  inputController, title),

            ],
          ),
        ),
      ),
    ).show();
  }


  _buildTextField(TextEditingController controller, String labelText) {

if (labelText == "Password") {
      return Column(
        children: [ Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: Color(0xFFffffff).withOpacity(0.4)),
          child: TextFormField(
            validator: (value) {
              double strength = estimatePasswordStrength(value);
              if (value.isEmpty) {
                return 'This field is required.';
              }
              return null;
            },
            obscureText: true,
            controller: OldPasswordController,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: "Old Password",
                labelStyle: TextStyle(
                    color: Colors.blue, fontStyle: FontStyle.italic),

                // prefix: Icon(icon),
                border: InputBorder.none),
          ),
        ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                color: Color(0xFFffffff).withOpacity(0.4)),
            child: TextFormField(
              validator: (value) {
                double strength = estimatePasswordStrength(value);
                if (value.isEmpty) {
                  return 'This field is required.';
                } else if (value
                    .trim()
                    .length < 6) {
                  return 'Password should be at least 6 characters.';
                } else if (strength < 0.5) {
                  return 'This password is weak.';
                } else if (PasswordController.text.trim() !=
                    ConPasswordController.text.trim()) {
                  return "Those passwords didn't match. Try again.";
                }
                return null;
              },
              obscureText: true,
              controller: controller,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: labelText,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontStyle: FontStyle.italic),

                  // prefix: Icon(icon),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                color: Color(0xFFffffff).withOpacity(0.4)),
            child: TextFormField(
              validator: (value) {
                double strength = estimatePasswordStrength(value);
                if (value.isEmpty) {
                  return 'This field is required.';
                } else if (value
                    .trim()
                    .length < 6) {
                  return 'Password should be at least 6 characters.';
                } else if (strength < 0.5) {
                  return 'This password is weak.';
                } else if (PasswordController.text.trim() !=
                    ConPasswordController.text.trim()) {
                  return "Those passwords didn't match. Try again.";
                }
                return null;
              },
              obscureText: true,
              controller: ConPasswordController,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(
                      color: Colors.blue, fontStyle: FontStyle.italic),

                  // prefix: Icon(icon),
                  border: InputBorder.none),
            ),
          ),
        ],
      );
    } else if (labelText == "Certification" || labelText == "Work Experience" || labelText == "Educational Background"){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            color: Color(0xFFffffff).withOpacity(0.4)),
        child: TextFormField(
          validator: (value) {

            if (value.isEmpty) {
              return 'This field is required.';

            }else if(labelText == "Mobile Number"){

              String patttern = r'(^(09|\+639)\d{9}$)';
              RegExp regExp = new RegExp(patttern);
              if (!regExp.hasMatch(value)) {
                return 'Please enter valid mobile number';
              }

            }
            return null;
          },
          controller: controller,
          style: TextStyle(fontSize: 15),
          minLines: 3,
          maxLines: null,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),

              // prefix: Icon(icon),
              border: InputBorder.none),
        ),
      );

    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            color: Color(0xFFffffff).withOpacity(0.4)),
        child: TextFormField(
          validator: (value) {

            if (value.isEmpty) {
              return 'This field is required.';

            }else if(labelText == "Mobile Number"){

              String patttern = r'(^(09|\+639)\d{9}$)';
              RegExp regExp = new RegExp(patttern);
              if (!regExp.hasMatch(value)) {
                return 'Please enter valid mobile number';
              }

            }
            return null;
          },
          controller: controller,
          style: TextStyle(fontSize: 15),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),

              // prefix: Icon(icon),
              border: InputBorder.none),
        ),
      );
    }




  }





  bool _isButtonDisabled = false;
  final _scrollController = ScrollController();
  final _scrollDialogController = ScrollController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Navigation()))
          ,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('EDIT PROFILE', style: TextStyle(
            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.white,
      ),

      body:
          StreamBuilder(
          stream: getUserDataSnapshots(context),
          builder: (context, AsyncSnapshot<List<UserData>>  profileSnapshot) {
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
                            child: Scrollbar(
                              controller: _scrollController, // <---- Here, the controller
                              isAlwaysShown: true, // <---- Required
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: getImage,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            child:
                                            ClipOval(
                                              child:
                                              (_image != null) ? Image.file(
                                                  _image, width: 90,
                                                  height: 90, fit: BoxFit.fill)
                                                  : new Image.network(
                                                  user.photo, width: 90,
                                                  height: 90, fit: BoxFit.fill),
                                            ),

                                            radius: 45,
                                          ),
                                        ),
                                        Text("Change Photo"),
                                        SizedBox(height: 50),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("First Name",
                                                style: TextStyle(fontSize: 15)),
                                            Row(
                                              children: [

                                                InkWell(
                                                  onTap: _isButtonDisabled
                                                      ? () {}
                                                      : () async {
                                                    setState(() =>
                                                    _isButtonDisabled = true);
                                                    nameController.text = user.first_name;
                                                    //EasyLoading.show(status: 'loading...');
                                                    String result = await _awesomeDialogEdit(
                                                      'first_name',
                                                      'First Name',
                                                      nameController,
                                                    );
                                                  },
                                                  child:
                                                  Row(
                                                    children: [
                                                      Text(user.first_name),
                                                      Icon(Icons.keyboard_arrow_right),
                                                    ],
                                                  ),

                                                )
                                              ],
                                            ),


                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Divider(thickness: 1, color: Colors.grey),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Last Name",
                                                style: TextStyle(fontSize: 15)),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: _isButtonDisabled
                                                      ? () {}
                                                      : () async {
                                                    setState(() =>
                                                    _isButtonDisabled = true);
                                                    lnameController.text =  user.last_name;
                                                    //EasyLoading.show(status: 'loading...');
                                                    String result = await _awesomeDialogEdit(
                                                      'last_name',
                                                      'Last Name',
                                                      lnameController,

                                                    );
                                                  },
                                                  child:
                                                  Row(
                                                    children: [
                                                      Text(user.last_name),
                                                      Icon(Icons.keyboard_arrow_right),
                                                    ],
                                                  ),

                                                )
                                              ],
                                            ),


                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Divider(thickness: 1, color: Colors.grey),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Password",
                                                style: TextStyle(fontSize: 15)),
                                            Row(
                                              children: [


                                                InkWell(
                                                  onTap: _isButtonDisabled
                                                      ? () {}
                                                      : () async {
                                                    setState(() =>
                                                    _isButtonDisabled = true);

                                                    emailController.text = user.email;

                                                    String result = await _awesomeDialogEdit(
                                                      'password',
                                                      'Password',
                                                      PasswordController,
                                                    );
                                                  },
                                                  child:
                                                  Row(
                                                    children: [
                                                      Text('*********'),
                                                      Icon(Icons.keyboard_arrow_right),
                                                    ],
                                                  ),

                                                )

                                              ],
                                            ),


                                          ],
                                        ),



                                      ],
                                    ),
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
  final email,password,photo,first_name,last_name;

  const UserData(
      this.email,this.password,this.photo,this.first_name, this.last_name);
}

Stream<List<UserData>> getUserDataSnapshots(BuildContext context) async* {
  final uid = await Provider.of(context).auth.getCurrentUID();
  //yield* FirebaseFirestore.instance.collection('profile').where('profile_id', isEqualTo: uid).snapshots();

  var profile = FirebaseFirestore.instance.collection('profile').where('profile_id', isEqualTo: uid).snapshots();
  var data = List<UserData>();
  await for (var profileSnapshot in profile) {
    for (var profileDoc in profileSnapshot.docs) {
      var ProfileData;
      var emailSnapshot = await FirebaseFirestore.instance.collection("admin").doc(uid).get();
      ProfileData = UserData(
        emailSnapshot.get('email'),
        emailSnapshot.get('password'),
        profileSnapshot.docs[0].get('photo'),
        profileSnapshot.docs[0].get('first_name'),
        profileSnapshot.docs[0].get('last_name'),
      );

      data.add(ProfileData);
    }
    yield data;
  }

}




_awesomeDialogResult(String title,String content,BuildContext context, DialogType DialogType, IconData icon_type){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType,
      title: title,
      desc: content,
      btnOkOnPress: () {
      },
      btnOkIcon: icon_type,
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
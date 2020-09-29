import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hero_admin/pages/account.dart';
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
final TextEditingController mobileController = TextEditingController();
final TextEditingController genderController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController birthdayController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController PasswordController = TextEditingController();
final TextEditingController ConPasswordController = TextEditingController();
final TextEditingController OldPasswordController = TextEditingController();

final TextEditingController streetController = TextEditingController();
final TextEditingController provinceController = TextEditingController();
final TextEditingController cityController = TextEditingController();
final TextEditingController barangayController = TextEditingController();
final TextEditingController zipController = TextEditingController();

final TextEditingController EducationalBackgroundController = TextEditingController();
final TextEditingController CertificationController = TextEditingController();
final TextEditingController WorkExperienceController = TextEditingController();

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
              Navigator.pop(context, true);
              final uid = await Provider.of(context).auth.getCurrentUID();
              var addressSnapshot = await FirebaseFirestore.instance.collection("address").where('profile_id', isEqualTo: uid).get();
              if(title == "Address") {
                await db.collection('address').doc(addressSnapshot.docs[0].id)
                    .update(
                    {
                      'street': streetController.text,
                      'province': provinceController.text,
                      'city': cityController.text,
                      'barangay': barangayController.text,
                      'zip': zipController.text,
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
              }else if(title == "Password"){

                User firebaseUser;
                String errorMessage;

                try{
                        final auth = Provider.of(context).auth;
                        User uidResult = await auth.signInWithEmailAndPassword(emailController.text.trim(), OldPasswordController.text);


                        uidResult.updatePassword(PasswordController.text.trim()).then((_) async {

                          var heroSnapshot = await FirebaseFirestore.instance.collection("client").where('profile_id', isEqualTo: uidResult).get();
                          await db.collection('client').doc(heroSnapshot.docs[0].id)
                              .update(
                              {
                                'password': PasswordController.text.trim(),
                              });
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


  _buildTextField(
      TextEditingController controller, String labelText) {


    List<Province> _provinces = getProvinces();
    var _currentSelectedValue = _provinces.first;
    provinceController.text = _currentSelectedValue.name;

    List<City> _cities = getCities();
    _cities.removeWhere((city) => city.province != "MM");
    City _currentSelectedCity = _cities.first;
    cityController.text = _currentSelectedCity.name;

    List<String> _gender = ['None','Male','Female'];
    String _currentSelectedGender = genderController.text;

    if (labelText == "Birthday") {
      return StatefulBuilder(
          builder: (context, setState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      color: Color(0xFFffffff).withOpacity(0.4)),
                  child: Center(
                    child: Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                RaisedButton(
                  onPressed: () async {
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate, // Refer step 1
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2021),
                    );
                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                        birthdayController.text =
                            DateFormat('yyyy-MM-dd').format(picked);
                      });
                  },
                  child: Text(
                    'Select date',
                    style:
                    TextStyle(color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Color(0xFF93ca68),
                ),

              ],
            );
          }
      );
    }else if(labelText == "Address") {
      return StatefulBuilder(
          builder: (context, setState) {
            return Scrollbar(
              controller: _scrollDialogController, // <---- Here, the controller
              isAlwaysShown: true, // <---- Required
              child: SingleChildScrollView(
                controller: _scrollDialogController,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                        controller: streetController,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10),
                            labelText: "Street",
                            labelStyle: TextStyle(color: Colors.blue,
                                fontStyle: FontStyle.italic),

                            // prefix: Icon(icon),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          color: Color(0xFFffffff).withOpacity(0.4)),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10),
                            labelText: "Province",
                            labelStyle: TextStyle(color: Colors.blue,
                                fontStyle: FontStyle.italic),

                            // prefix: Icon(icon),
                            border: InputBorder.none),
                        value: _currentSelectedValue,
                        items: _provinces.map((Province value) {
                          return DropdownMenuItem<Province>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (Province newValue) {
                          setState(() {
                            List<City> cities = getCities();

                            cities.removeWhere((city) =>
                            city.province != newValue.id);

                            _cities = cities;
                            _currentSelectedValue = newValue;
                            provinceController.text = newValue.name;
                            _currentSelectedCity = null;
                          });
                        },

                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          color: Color(0xFFffffff).withOpacity(0.4)),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        validator: (value) {
                          if (value == null) {
                            return 'This field is required.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10),
                            labelText: "City",
                            labelStyle: TextStyle(color: Colors.blue,
                                fontStyle: FontStyle.italic),

                            // prefix: Icon(icon),
                            border: InputBorder.none),
                        value: _currentSelectedCity,
                        items: _cities?.map((City value) {
                          return DropdownMenuItem<City>(
                            value: value,
                            child: Text(value.name),
                          );
                        })?.toList(),
                        onChanged: (City newValue) {
                          setState(() {
                            _currentSelectedCity = newValue;
                            cityController.text = _currentSelectedCity.name;
                          });
                        },

                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                        controller: barangayController,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10),
                            labelText: "Barangay",
                            labelStyle: TextStyle(color: Colors.blue,
                                fontStyle: FontStyle.italic),

                            // prefix: Icon(icon),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                        controller: zipController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10),
                            labelText: "ZIP",
                            labelStyle: TextStyle(color: Colors.blue,
                                fontStyle: FontStyle.italic),

                            // prefix: Icon(icon),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      );
    }else if (labelText == "Gender") {

      return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      color: Color(0xFFffffff).withOpacity(0.4)),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    validator: (value) {
                      if (value == null) {
                        return 'This field is required.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10),
                        labelText: "Gender",
                        labelStyle: TextStyle(color: Colors.blue,
                            fontStyle: FontStyle.italic),

                        // prefix: Icon(icon),
                        border: InputBorder.none),
                    value: _currentSelectedGender,
                    items: _gender?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })?.toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        genderController.text = newValue;
                      });
                    },

                  ),
                ),

              ],
            );
          }
      );

    }else if (labelText == "Password") {
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
                  MaterialPageRoute(builder: (context) => Account()))
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
                                            Text("Mobile Number",
                                                style: TextStyle(fontSize: 15)),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: _isButtonDisabled
                                                      ? () {}
                                                      : () async {
                                                    setState(() =>
                                                    _isButtonDisabled = true);
                                                    mobileController.text = user.contact;
                                                    //EasyLoading.show(status: 'loading...');
                                                    String result = await _awesomeDialogEdit(
                                                      'mobile',
                                                      'Mobile Number',
                                                      mobileController,
                                                    );
                                                  },
                                                  child:
                                                  Row(
                                                    children: [
                                                      Text(user.contact),
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
                                            Text("Gender",
                                                style: TextStyle(fontSize: 15)),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: _isButtonDisabled
                                                      ? () {}
                                                      : () async {
                                                    setState(() =>
                                                    _isButtonDisabled = true);
                                                    genderController.text = user.gender;
                                                    //EasyLoading.show(status: 'loading...');
                                                    String result = await _awesomeDialogEdit(
                                                      'gender',
                                                      'Gender',
                                                      genderController,
                                                    );
                                                  },
                                                  child:
                                                  Row(
                                                    children: [
                                                      Text(user.gender),
                                                      Icon(Icons.keyboard_arrow_right),
                                                    ],
                                                  ),

                                                )
                                              ],
                                            ),


                                          ],
                                        ),

                                        // SizedBox(height: 10),
                                        // Divider(thickness:1,color: Colors.grey),
                                        // SizedBox(height: 10),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Text("Email Address",
                                        //         style: TextStyle( fontSize: 15 )),
                                        //     Row(
                                        //       children: [
                                        //         InkWell(
                                        //           onTap:  _isButtonDisabled ? (){} : () async {
                                        //             setState(() => _isButtonDisabled = true);
                                        //             lnameController.text = snapshot.data.documents[index].get('Mobile');
                                        //             //EasyLoading.show(status: 'loading...');
                                        //             String result = await _awesomeDialogEdit(
                                        //                 'Mobile',
                                        //                 'Mobile Number',
                                        //                 lnameController,
                                        //                 context
                                        //             );
                                        //           },
                                        //           child:
                                        //           Row(
                                        //             children: [
                                        //               Text(snapshot.data.documents[index].get('Mobile')),
                                        //               Icon(Icons.keyboard_arrow_right),
                                        //             ],
                                        //           ),
                                        //
                                        //         )
                                        //       ],
                                        //     ),
                                        //
                                        //
                                        //   ],
                                        // ),
                                        SizedBox(height: 10),
                                        Divider(thickness: 1, color: Colors.grey),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Birthday",
                                                style: TextStyle(fontSize: 15)),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: _isButtonDisabled
                                                      ? () {}
                                                      : () async {
                                                    setState(() =>
                                                    _isButtonDisabled = true);
                                                    birthdayController.text = user.birthday;

                                                    //EasyLoading.show(status: 'loading...');
                                                    String result = await _awesomeDialogEdit(
                                                      'birthday',
                                                      'Birthday',
                                                      birthdayController,

                                                    );
                                                  },
                                                  child:
                                                  Row(
                                                    children: [
                                                      Text(user.birthday),
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
                                            Text("Address",
                                                style: TextStyle(fontSize: 15)),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: _isButtonDisabled
                                                      ? () {}
                                                      : () async {
                                                    setState(() =>
                                                    _isButtonDisabled = true);

                                                    streetController.text = user.street;
                                                    provinceController.text = user.province;
                                                    cityController.text = user.city;
                                                    barangayController.text = user.barangay;
                                                    zipController.text = user.zip;
                                                    //EasyLoading.show(status: 'loading...');
                                                    String result = await _awesomeDialogEdit(
                                                      'address',
                                                      'Address',
                                                      addressController,
                                                    );
                                                  },
                                                  child:
                                                  Row(
                                                    children: [
                                                      Text('edit'),
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
  final email,password,photo,first_name,last_name,
      birthday,gender,contact,
      province,city,barangay,street,zip;

  const UserData(
      this.email,this.password,this.photo,this.first_name, this.last_name,
      this.birthday,this.gender,this.contact,
      this.province,this.city,this.barangay,this.street,this.zip);
}

Stream<List<UserData>> getUserDataSnapshots(BuildContext context) async* {
  final uid = await Provider.of(context).auth.getCurrentUID();
  //yield* FirebaseFirestore.instance.collection('profile').where('profile_id', isEqualTo: uid).snapshots();

  var profile = FirebaseFirestore.instance.collection('profile').where('profile_id', isEqualTo: uid).snapshots();
  var data = List<UserData>();
  await for (var profileSnapshot in profile) {
    for (var profileDoc in profileSnapshot.docs) {
      var ProfileData;
      var emailSnapshot = await FirebaseFirestore.instance.collection("hero").where('profile_id', isEqualTo: uid).get();
      var heroSnapshot = await FirebaseFirestore.instance.collection("hero_info").where('profile_id', isEqualTo: uid).get();
      var addressSnapshot = await FirebaseFirestore.instance.collection("address").where('profile_id', isEqualTo: uid).get();
      var contactSnapshot = await FirebaseFirestore.instance.collection("contact").where('profile_id', isEqualTo: uid).get();
      ProfileData = UserData(
        emailSnapshot.docs[0].get('email'),
        emailSnapshot.docs[0].get('password'),
        profileSnapshot.docs[0].get('photo'),
        profileSnapshot.docs[0].get('first_name'),
        profileSnapshot.docs[0].get('last_name'),
        profileSnapshot.docs[0].get('birthday'),
        profileSnapshot.docs[0].get('gender'),
        contactSnapshot.docs[0].get('value'), // mobile
        addressSnapshot.docs[0].get('province'),
        addressSnapshot.docs[0].get('city'),
        addressSnapshot.docs[0].get('barangay'),
        addressSnapshot.docs[0].get('street'),
        addressSnapshot.docs[0].get('zip'),
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
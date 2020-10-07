import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hero_admin/pages/manage_services.dart';
import 'package:hero_admin/pages/navigation.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:toast/toast.dart';
import 'package:toggle_switch/toggle_switch.dart';

final _formKey = GlobalKey<FormState>();

final TextEditingController CategoryIDController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
final TextEditingController enableInitialController = TextEditingController();
final TextEditingController iconController = TextEditingController(text: '59322');


AwesomeDialog awedialog;
final db = FirebaseFirestore.instance;
Icon _icon;
int iconData = 59322;

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}





class _CategoriesState extends State<Categories> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryList(),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () async {
          nameController.text = "";
          descriptionController.text = "";
          enableInitialController.text = '0';
          iconController.text = '59322';
          await _awesomeDialogAdd('add',context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }


}



class CategoryList extends StatefulWidget {
  CategoryList({Key key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

@override



List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return  snapshot.map((data) => _buildListItem(context, data)).toList();
}


DataRow _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
  return DataRow(
      onSelectChanged: (bool selected) async {
        if (selected) {
          CategoryIDController.text = snapshot.id;
          nameController.text = snapshot.data()['name'];
          descriptionController.text = snapshot.data()['description'];
          iconController.text = snapshot.data()['icon'].toString();
          if(snapshot.data()['enable'] == true){
            enableInitialController.text = '0';
          }else{
            enableInitialController.text = '1';
          }
          await _awesomeDialogAdd('update',context);
        }
      },
      cells: [
        DataCell(Text(snapshot.data()['name'])),
        DataCell(Text(snapshot.data()['description'])),
        DataCell(Icon(
          IconData(snapshot.data()['icon'], fontFamily: 'MaterialIcons'),
        )),
        DataCell(Text(snapshot.data()['enable'] ? "Active" : "Inactive")),
      ]);
}
Widget build(BuildContext context) {



  return
    SafeArea(
    child: StreamBuilder<QuerySnapshot>(
      stream:  FirebaseFirestore.instance.collection('service_category').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const SpinKitDoubleBounce(
            color: Color(0xFF93ca68),
            size: 50.0);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              DataTable(
                showCheckboxColumn: false,
                columns: const <DataColumn>[
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Icon')),
                  DataColumn(label: Text('Status')),
                ],
                   rows: _buildList(context, snapshot.data.docs)
              ),
            ],
          ),
        );
      }
    ),
  );

}

}

_NormalTextField(TextEditingController controller, String labelText){
  return Container(
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

_TextAreaField(TextEditingController controller, String labelText){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        color: Color(0xFFffffff).withOpacity(0.4)),
    child: TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 5,
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is required.';
        }
        return null;
      },
      controller: controller,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
          border: InputBorder.none),
    ),
  );
}

_TextIconField(TextEditingController controller, String labelText){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        color: Color(int.parse('0xFFffffff')).withOpacity(0.4)),
    child: TextFormField(
      readOnly: true,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is required.';
        }
        return null;
      },
      controller: controller,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: "Icon Code",
          labelStyle: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
          border: InputBorder.none),
    ),
  );
}


_pickIcon(BuildContext context) async {
  IconData icon = await FlutterIconPicker.showIconPicker(context,
    iconSize: 40,
    iconPickerShape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    title: Text('Pick an icon',
        style: TextStyle(fontWeight: FontWeight.bold)),
    closeChild: Text(
      'Close',
      textScaleFactor: 1.25,
    ),
    searchHintText: 'Search icon...',
    noResultsText: 'No results for:',
    iconPackMode: IconPack.material,
  );

  iconData = icon.codePoint;
  _icon = Icon(icon);


}

Future _awesomeDialogAdd(String action,BuildContext context) async {

  awedialog = AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.INFO,
    dismissOnTouchOutside: true,
    keyboardAware: true,
    // btnCancelOnPress: () {
    //   Navigator.of(context).pop();
    // },
    btnOk:
    FlatButton(
        color: Color(0xFF13869f),
        minWidth: 200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () async {

          if (_formKey.currentState.validate()) {

            try {
              bool category_status;
              if(enableInitialController.text == "0"){
                category_status = true;
              }else{
                category_status = false;
              }
              if(action == "add"){
                await db.collection('service_category').add(
                    {
                      'name': nameController.text.trim(),
                      'description': descriptionController.text,
                      'icon': int.parse(iconController.text),
                      'enable': category_status,
                    });
                // _awesomeDialogResult(
                //     "Success", "Category Added Successfully", context,
                //     DialogType.SUCCES, Icons.check_circle);

                Toast.show("Category Added Successfully", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              }else{
                await db.collection('service_category').doc(CategoryIDController.text).update(
                    {
                      'name': nameController.text.trim(),
                      'description': descriptionController.text,
                      'icon': int.parse(iconController.text),
                      'enable': category_status,
                    });
                Toast.show("Category Updated Successfully", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                // _awesomeDialogResult(
                //     "Success", "Category Updated Successfully", context,
                //     DialogType.SUCCES, Icons.check_circle);

              }


              nameController.text = "";
              descriptionController.text = "";
              iconController.text = "";

            }catch(e){

              _formKey.currentState.reset();
              _awesomeDialogError(
                  e,
                  context
              );
            }
            Navigator.of(context, rootNavigator: true).pop();
            // Navigator.of(context, rootNavigator: true).pop();
            //setState(() {});
          }

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
            _NormalTextField(nameController, "Name"),
            SizedBox(height: 10),
            _TextAreaField(descriptionController, "Description"),
            SizedBox(height: 10),
            _TextIconField(iconController, "Icon"),
            FlatButton(
                color: Color(0xFF13869f),
                minWidth: 100,
                onPressed: () async {
                  await _pickIcon(context);
                  iconController.text = "$iconData";
                },
                child: Text("Select Icon", style: TextStyle(
                  color: Colors.white,fontSize: 12.0,
                ))),
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColor: Color(0xFF13869f),
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: int.parse(enableInitialController.text),
              labels: ['Active', 'Inactive'],
              icons: [FontAwesomeIcons.check, FontAwesomeIcons.times],
              onToggle: (index) {
                enableInitialController.text = index.toString();
                print(enableInitialController.text);
              },
            ),





          ],
        ),
      ),
    ),
  )..show();

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

_awesomeDialogResult(String title,String content,BuildContext context, DialogType DialogType, IconData icon_type){
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType,
      title: title,
      desc: content,
      btnOkOnPress: () {

        Navigator.of(context, rootNavigator: true).pop();

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ManageServices()),
        // );
      },
      btnOkIcon: icon_type,
      onDissmissCallback: () {
        debugPrint('Dialog Dissmiss from callback');
      }).show();
}
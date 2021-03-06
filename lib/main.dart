
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_admin/pages/account.dart';
import 'package:hero_admin/pages/edit.dart';
import 'package:hero_admin/pages/login.dart';
import 'package:hero_admin/pages/navigation.dart';
import 'package:hero_admin/services/auth_service.dart';
import 'package:hero_admin/widgets/provider_widget.dart';

GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Provider(
    auth: AuthService(),
    child: GetMaterialApp(
      title: 'Hero Partner',
      debugShowCheckedModeBanner: false,
      home: HomeController(),
      theme: ThemeData(
        brightness: Brightness.light,

        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[50],
        primaryColorBrightness: Brightness.light,

        //this is what you want
        accentColor: Color(0xFF13869f),
        accentColorBrightness: Brightness.light,
          highlightColor: Color(0xFF93ca68),

      ),
    ),
  ),
  );
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              final bool signedIn = snapshot.hasData;
              return signedIn ? Navigation() : Login();
            }
              return CircularProgressIndicator();
          }
        );
  }
}






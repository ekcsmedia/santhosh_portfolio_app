import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:permission_handler/permission_handler.dart';


import 'Contact_App/Contacts_Home.dart';
import 'E_Commerce/e_Commerce_Home.dart';
import 'E_Learning/ELearningHome.dart';
import 'GPS_Location_Service/GPS_GuestLogin.dart';
import 'GPS_Location_Service/GPS_MAP_Home.dart';
import 'NEWS_APP/NEWS_app.dart';
import 'OTP_Login/OTP_Login.dart';
import 'OTP_Login/otp_home.dart';
import 'QR_Code/QR_App.dart';
import 'Recipe_App/Recipe_App.dart';
import 'Video_Embedding/Video_App.dart';
import 'Web_View/Web_View.dart';

final List<String> imgList = [
  'https://uploads-ssl.webflow.com/5f841209f4e71b2d70034471/60bb4a2e143f632da3e56aea_Flutter%20app%20development%20(2).png',
  'https://www.concettolabs.com/blog/wp-content/uploads/2019/07/flutter-desktop-app.jpg',
  'https://www.signitysolutions.com/blog/wp-content/uploads/2020/04/Flutter-app-development-signity-solutions-1024x512.png',
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      title: 'Named Routes',
      initialRoute: '/',
      routes: {
      '/': (context) => MyApp(),
     // '/second': (context) => Second_route(),
      }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Santhosh - Flutter Developer'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<void> _checkPermission() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    final isGpsOn = serviceStatus == ServiceStatus.enabled;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  @override
  void initState() {
    setState(() {
      //   _locationId = widget.user;
    });
    super.initState();
    _checkPermission();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image(image: Image
                .asset('assets/images/santhosh.jpg')
                .image,),
          ),
        ),
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Hello, How are you?',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                    ),
                    items: imgList.map((item) => Container(
                      child: Center(
                          child: Image.network(item, fit: BoxFit.cover, width: MediaQuery.of(context).size.width * 1.0)
                      ),
                    )).toList(),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: InkResponse (
                          child: SelectCard(choice: choices[index],),
                          onTap: () {

                            if (index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ECommerceHome())); }
                            else if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ELearningHome()));
                            }
                            else if (index == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GpsEnableHome()));
                            }
                            else if (index == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NewsAppHome()));
                            }
                            else if (index == 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RecipeAppHome()));
                            }
                            else if (index == 5) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => OtpMyHome()));
                            }
                            else if (index == 6) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => WebViewHome()));
                            }
                            else if (index == 7) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => VideoAppHome()));
                            }
                            else if (index == 8) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => OtpLoginScreen()));
                            }
                            else if (index == 18) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FlutterContactsExample()));
                            }
                           },
                          enableFeedback: true,
                      ),
                    );
                  }
                  )
              ),
            ),
          ],

        ),
      ),
    );
  }
}

/*
Route<dynamic> generateRoute(index) {
  if (index == 0) {
      return MaterialPageRoute(builder: (context) => HomeView()); }
  else if (index == 1) {
      return MaterialPageRoute(builder: (context) => LoginView()); }
  else {
    return MaterialPageRoute(builder: (context) => Second_route()); }
  }



 onTileClicked(index){
  switch (index) {
    case 0:
     return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Second_route()),

      );
    case 1:
      debugPrint("You tapped on item Contact");
      break;
    case 2:
      debugPrint("You tapped on item Map App");
      break;
    case 3:
      debugPrint("You tapped on item Phone");
      break;
    case 4:
      debugPrint("You tapped on item 4");
      break;
    case 5:
      debugPrint("You tapped on Settings");
      break;
    case 6:
      debugPrint("You tapped on Certificates");
      break;
    case 7:
      debugPrint("You tapped on WiFi");
      break;
    case 8:
      debugPrint("You tapped on Education App");
      break;
  }
}

*/
  class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
  }

  const List<Choice> choices = const <Choice>[
  const Choice(title: 'E Commerce', icon: Icons.local_grocery_store_outlined),
  const Choice(title: 'E Learning', icon: Icons.book),
  const Choice(title: 'GPS Map App', icon: Icons.location_on_outlined),
  const Choice(title: 'NEWS App', icon: Icons.tv),
  const Choice(title: 'Recipe App', icon: Icons.food_bank),
  const Choice(title: 'QR App', icon: Icons.qr_code),
  const Choice(title: 'Web View', icon: Icons.web),
  const Choice(title: 'Video App', icon: Icons.video_call_rounded),
  const Choice(title: 'OTP Login', icon: Icons.login),
  const Choice(title: 'Payment Gateway', icon: Icons.payment),
  const Choice(title: 'Firebase CRUD', icon: Icons.storage_outlined),
  const Choice(title: 'MySQL CRUD', icon: Icons.storage),
  const Choice(title: 'Firebase Auth', icon: Icons.lock_open),
  const Choice(title: 'MySQL Auth', icon: Icons.lock_open_rounded),
  const Choice(title: 'MySQL Query', icon: Icons.grid_4x4),
  const Choice(title: 'PDF Excel Doc', icon: Icons.picture_as_pdf),
  const Choice(title: 'State Management', icon: Icons.exposure_zero_outlined),
  const Choice(title: 'Notifications App', icon: Icons.notifications),
  const Choice(title: 'Contacts App', icon: Icons.contacts),];


  class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
  final TextStyle? textStyle = Theme.of(context).textTheme.headline6;
  return Card(
    color: Colors.blueAccent.shade200,
    child: Center(child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
              Expanded(child: Icon(choice.icon, size:50.0, color: textStyle!.color)),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(choice.title, style: textStyle),
              ),
  ]
  ),
  )
  );
  }
}

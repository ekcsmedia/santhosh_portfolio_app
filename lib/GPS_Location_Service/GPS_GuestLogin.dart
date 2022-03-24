import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart' as loc;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

import 'GPS_MAP_Home.dart';

class GpsEnableHome extends StatefulWidget {
  // late final String? name;
 // final User? user;
 // const Home({Key? key, required this.user}) : super(key: key);

  @override
  _GpsEnableHomeState createState() => _GpsEnableHomeState();
}

class _GpsEnableHomeState extends State<GpsEnableHome> {
// 1

  final loc.Location location = loc.Location();
  late StreamSubscription<loc.LocationData>? _locationSubscription;
  TextEditingController driverId = new TextEditingController();

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
  //late User? _locationId ;

 // get user => widget.user;
  @override
  void initState() {
    setState(() {
   //   _locationId = widget.user;
    });
    super.initState();
    _checkPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.indigoAccent,
          title: const Text(
            'Location Service',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    _getLocation();
                  },
                  child: Text('Add my location')),
              TextButton(
                  onPressed: () {
                    _listenLocation();
                  },
                  child: Text('Enable my live location')),
              TextButton(
                  onPressed: () {
                    _stopListening();
                  },
                  child: Text('Stop Sharing my live location')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => GPSHomes(),));
                  },
                  child: Text('Go to Location List')),

              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('location')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("Hi ${snapshot.data!.docs[index]['name']
                                    .toString()}"),

                              ); } ); }

                  ) )  ]));}


  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('location')
          .doc('AP1AuywBnqpi4NA7ZIXa')
          .set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
      //  'name': 'Driver - ${_locationId!.displayName}',
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance
          .collection('location')
          .doc('AP1AuywBnqpi4NA7ZIXa')
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'User',
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
}

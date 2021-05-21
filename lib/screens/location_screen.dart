import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
import 'package:hobby_hub_ui/models/user_model.dart';
import 'package:hobby_hub_ui/screens/user_profile.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  initState() {
    super.initState();
  }

  Set<Marker> markers = {};

  Future<void> getMarkers() async {
    try {
      List<User> following = await UserController().getUserFollowing();
      for (int i = 0; i < following.length; i++) {
        double long, lat;
        if (following[i].location != null &&
            following[i].location.trim().isNotEmpty) {
          lat = double.parse(following[i].location.split(',')[0]);
          long = double.parse(following[i].location.split(',')[1]);
          Marker marker = Marker(
              infoWindow: InfoWindow(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UserProfileScreen(
                              username: following[i].username)));
                },
                title: following[i].username,
              ),
              markerId: MarkerId(following[i].username),
              position: LatLng(lat, long));
          markers.add(marker);
        }
      }
      return;
    } catch (e) {
      print(e);
    }
  }

  Future<LatLng> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    _locationData = await location.getLocation();
    await getMarkers();
    print(_locationData.longitude);
    return LatLng(_locationData.latitude, _locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
            child: FutureBuilder(
                future: getLocation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print("snap:${snapshot.data}");
                    LatLng userLocation = snapshot.data;
                    if (userLocation != null)
                      UserController().updateUserLocation(
                          userLocation.latitude.toString(),
                          userLocation.longitude.toString());
                    return GoogleMap(
                        markers: markers,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                                target: snapshot.data, zoom: 14.4746) ??
                            LocationScreen._kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        });
                  } else
                    return Center(
                        child: SpinKitCircle(
                            color: Theme.of(context).primaryColor));
                })));
  }
}

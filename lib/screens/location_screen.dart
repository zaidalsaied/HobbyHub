import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hobby_hub_ui/controller/user_controller.dart';
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
    List<String> locationString =
        await UserController().getUserFollowingLocation();
    for (int i = 0; i < locationString.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(double.parse(locationString[i].split(',')[0]),
              double.parse(locationString[i].split(',')[1]))));
    }
    return;
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
                    LatLng userLocation = snapshot.data;
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

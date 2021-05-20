import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

//
  CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  initState() {
    super.initState();
    getLocation();
  }

  Location location = new Location();

  bool _serviceEnabled;

  PermissionStatus _permissionGranted;

  LocationData _locationData;

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
    widget._kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(_locationData.latitude, _locationData.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    print('lat ${_locationData.latitude}');
    print('long ${_locationData.longitude}');
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
                print('loc ${snapshot.data}');
                return GoogleMap(
                  markers: {
                    Marker(
                        markerId: MarkerId("1"),
                        position: snapshot.data ?? LatLng(32.56483, 35.8619039))
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                        target: snapshot.data,
                        zoom: 14.4746,
                      ) ??
                      LocationScreen._kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                );
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var markers = HashSet<Marker>(); //! collection
  late BitmapDescriptor markerIcon;
  List<Polyline> polyLine = [];
  getCustomMarker() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/workshop.jpg",
    );
  }

  @override
  void initState() {
    super.initState();
    getCustomMarker();
    createPolyLine();
  }

  Set<Polygon> polygon() {
    var polygonCoords = <LatLng>[];
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));

    var polygonSet = <Polygon>{};
    polygonSet.add(
      Polygon(
        polygonId: const PolygonId("1"),
        points: polygonCoords,
        strokeColor: Colors.red,
        strokeWidth: 1,
      ),
    );
    return polygonSet;
  }

  Set<Circle> circle = {
    const Circle(
      circleId: CircleId('1'),
      center: LatLng(29.990940, 31.149248),
      radius: 1000,
      strokeWidth: 1,
    )
  };
  createPolyLine() {
    polyLine.add(
      Polyline(
          patterns: [
            PatternItem.dash(20),
            PatternItem.gap(10),
          ],
          polylineId: const PolylineId("1"),
          color: Colors.red,
          width: 3,
          points: const [
            LatLng(29.990000, 31.149000),
            LatLng(29.999000, 31.149900),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Google Maps"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            //! defulat Map is MapType.normal
            //!mapType: MapType.none,
            polylines: polyLine.toSet(),
            circles: circle,
            polygons: polygon(),
            initialCameraPosition: const CameraPosition(
              target: LatLng(29.990940, 31.149248),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                markers.add(
                  Marker(
                    //!  icon: markerIcon,
                    markerId: const MarkerId('1'),
                    position: const LatLng(30.0444, 31.2357),
                    infoWindow: InfoWindow(
                      title: "Appify Comapny ",
                      snippet: "Appify Comapny this software house",
                      onTap: () {
                        //!  print("Kareem mohamed is the best ");
                      },
                    ),
                  ),
                );
              });
            },
            markers: markers,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: 100,
            width: 100,
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/photo.jpg"),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomCenter,
            child: const FittedBox(
              child: Text(
                "This my First Google Maps App",
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

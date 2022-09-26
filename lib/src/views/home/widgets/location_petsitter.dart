import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import '../../../../helper/location_helper.dart';
import '../maps_petsitter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPrieview(double lat, double lang) {
    final imageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lang);
    setState(
      () {
        _previewImageUrl = imageUrl;
      },
    );
  }

  // Future<void> _getUserCurrentLocation() async {
  //   //print("dds");
  //   final locData = await Location().getLocation();
  //   print(locData.latitude);
  //   print(locData.longitude);
  //   widget.onSelectPlace(locData.latitude, locData.longitude);
  //   _showPrieview(locData.latitude!, locData.longitude!);
  // }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapView(),
      ),
    );
    _showPrieview(selectedLocation!.latitude, selectedLocation.longitude);
    //widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pet Location',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text('Get Directions on the map'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: _selectOnMap,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

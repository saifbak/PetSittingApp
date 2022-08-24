import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import '../../../../helper/location_helper.dart';
import '../maps_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

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

  Future<void> _getUserCurrentLocation() async {
    //print("dds");
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    widget.onSelectPlace(locData.latitude, locData.longitude);
    _showPrieview(locData.latitude!, locData.longitude!);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    _showPrieview(selectedLocation!.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Enter Location',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(10)),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.darkGray),
                )
              : Padding(
                  padding: EdgeInsets.all(3),
                  child: Image.network(
                    _previewImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Current Location'),
              textColor: AppColors.primaryColor,
              onPressed: _getUserCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text('Select on Map'),
              textColor: AppColors.primaryColor,
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

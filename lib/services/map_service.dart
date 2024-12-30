// import 'package:flutter/material.dart';
// import 'package:maaldo_app/services/global.dart';
// import 'package:map_location_picker/map_location_picker.dart';

// class MapService {
//   static Future<void> getLocation(
//       BuildContext context, VoidCallback setStateCallback) async {
//     Navigator.of(context, rootNavigator: true).push(
//       MaterialPageRoute(
//         builder: (context) {
//           return MapLocationPicker(
//             compassEnabled: true,
//             hideMapTypeButton: true,
//             hideMoreOptions: true,
//             apiKey: "AIzaSyBfsDF3THaf4CZOfdwi8ZgW5qJAlZP-WvA",
//             popOnNextButtonTaped: true,
//             currentLatLng: const LatLng(24.8607, 67.0011),
//             onNext: (GeocodingResult? result) {
//               if (result != null) {
//                 setStateCallback();
//                 Global.addressController.text = result.formattedAddress ?? "";
//                 Global.latitude = result.geometry.location.lat;
//                 Global.longitude = result.geometry.location.lng;
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }

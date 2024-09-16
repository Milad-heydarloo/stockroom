
import 'package:flutter/material.dart';
import 'package:project/BuySell_GetX/Supiller/Location_GetX/supplier_list_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SupplierListScreens(),
    );
  }
}



// // دیالوگ برای افزودن موقعیت
// class AddLocationDialog extends StatefulWidget {
//   @override
//   _AddLocationDialogState createState() => _AddLocationDialogState();
// }
//
// class _AddLocationDialogState extends State<AddLocationDialog> {
//   LatLng? selectedLocation;
//   final TextEditingController _searchController = TextEditingController();
//   double _zoom = 15;
//   MapController _mapController = MapController();
//   List<Location> _searchResults = [];
//   final String apiKey = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1In0.eyJhdWQiOiIyODIxMyIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1IiwiaWF0IjoxNzIxOTQwODg3LCJuYmYiOjE3MjE5NDA4ODcsImV4cCI6MTcyNDUzMjg4Nywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.P-HVICCEemigM5vv_lYuxVogPRp3_Tpa1-6zJWONRJ9BfsWXKd4B6FPgnxmJg1wkSGOXc_GFFoeZuFrf9nRfJzwdofkbFbI9yrtWWMATW2PIY8zjd_2SoZ4O94HE-AfyPOO4Dq_V7TJV1xiGinIJdyFCCfMBAuxN-2p8etP5UF2R6r9gDqxXpeVXiHbDx2zB9nTpONG_rlCi26SJ4Y63rDhsAOppdW6v0bP8bF7wkcOJ_z2lwzaWpcOnvJ0uP0cnYc_y9MiINw_P0g79MWMV-ntFNaaj_LU5G_kvSb9y0uWbmFrPgLoEgRFkdkRK2OEAORd9b5ux_iJGnkYV39UHPQ'; // کلید API خود را وارد کنید
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       selectedLocation = LatLng(position.latitude, position.longitude);
//       _mapController.move(selectedLocation!, _zoom);
//     });
//   }
//
//
//
//
//   Future<void> _searchLocation(String query) async {
//     final url = Uri.parse('https://map.ir/search/v2/autocomplete');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'x-api-key': apiKey, // اطمینان حاصل کنید که apiKey را درست تنظیم کرده‌اید
//       },
//       body: jsonEncode({
//         'text': query,
//         // استفاده صحیح از کلید برای فیلتر
//         '\$filter': 'city eq تهران' // باید به صورت String باشد و \ را برای جلوگیری از تداخل استفاده کنید
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data is Map && data.containsKey('value')) {
//         setState(() {
//           _searchResults = (data['value'] as List)
//               .map((item) => Location.fromJson(item as Map<String, dynamic>))
//               .toList();
//         });
//       } else {
//         print('Unexpected data format');
//       }
//     } else {
//       print('Failed to fetch search results');
//       print('Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   }
//
//   void _moveToLocation(double lat, double lon) {
//     final newLocation = LatLng(lat, lon);
//     setState(() {
//       selectedLocation = newLocation;
//       _mapController.move(newLocation, _zoom);
//       _searchResults = [];
//       _searchController.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               minZoom: 9, // مقدار زوم مینیموم
//               maxZoom: 18,
//               center: selectedLocation ?? LatLng(35.7045368,51.4045376),
//               zoom: _zoom,
//               onTap: (tapPosition, point) {
//                 setState(() {
//                   selectedLocation = point;
//                 });
//               },
//             ),
//             children: [
//               TileLayer(
//                   urlTemplate:
//                   "https://map.ir/shiveh/xyz/1.0.0/Shiveh:Shiveh@EPSG:3857@png/{z}/{x}/{y}.png"
//                       "?x-api-key=${apiKey}"),
//
//               if (selectedLocation != null)
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       point: selectedLocation!,
//                       builder: (ctx) => Icon(
//                         Icons.location_on,
//                         color: Colors.red,
//                         size: 40.0,
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//           Positioned(
//             top: 10,
//             left: 10,
//             right: 10,
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search Location',
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                   ),
//                   onSubmitted: _searchLocation,
//                   onChanged: (value) {
//                     if (value.isEmpty) {
//                       setState(() {
//                         _searchResults = [];
//                       });
//                     }
//                   },
//                 ),
//                 if (_searchResults.isNotEmpty)
//                   Container(
//                     color: Colors.white,
//                     height: 200,
//                     child: ListView.builder(
//                       itemCount: _searchResults.length,
//                       itemBuilder: (context, index) {
//                         final result = _searchResults[index] as Location;
//                         return ListTile(
//                           title: Text(result.title),
//                           subtitle: Text('${result.address} \nLat: ${result.coordinates[1_2]}, Lon: ${result.coordinates[0]}'),
//                           onTap: () {
//                             final lat = result.coordinates[1_2];
//                             final lon = result.coordinates[0];
//                             _moveToLocation(lat, lon);
//                           },
//                         );
//                       },
//                     ),
//                   ),
//
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     FloatingActionButton(
//                       heroTag: 'zoom_in',
//                       onPressed: () {
//                         setState(() {
//                           _zoom++;
//
//                           _mapController.move(_mapController.center, _zoom);
//                         });
//                       },
//                       child: Icon(Icons.zoom_in),
//                     ),
//                     SizedBox(width: 10),
//                     FloatingActionButton(
//                       heroTag: 'zoom_out',
//                       onPressed: () {
//                         setState(() {
//                           _zoom--;
//                           print(_zoom);
//                           _mapController.move(_mapController.center, _zoom);
//                         });
//                       },
//                       child: Icon(Icons.zoom_out),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (selectedLocation != null)
//             Positioned(
//               bottom: 10,
//               left: 10,
//               right: 10,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(selectedLocation);
//                 },
//                 child: Text('Select Location'),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
//
// Helper function to parse location strings





// class AddSupplierDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final SupplierController controller = Get.find();
//     final companyNameController = TextEditingController();
//     final addressController = TextEditingController();
//     final phoneNumberController = TextEditingController();
//     final mobileNumberController = TextEditingController();
//     LatLng? selectedLocation;
//
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         TextField(
//           controller: companyNameController,
//           decoration: InputDecoration(labelText: 'نام شرکت'),
//         ),
//         TextField(
//           controller: addressController,
//           decoration: InputDecoration(labelText: 'آدرس'),
//         ),
//         TextField(
//           controller: phoneNumberController,
//           decoration: InputDecoration(labelText: 'شماره تلفن'),
//         ),
//         TextField(
//           controller: mobileNumberController,
//           decoration: InputDecoration(labelText: 'شماره موبایل'),
//         ),
//         SizedBox(height: 10),
//         ElevatedButton(
//           onPressed: () async {
//             selectedLocation = await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AddLocationDialog(); // فرض بر این است که دیالوگ انتخاب مکان دارید
//               },
//             );
//           },
//           child: Text('انتخاب مکان'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (companyNameController.text.isEmpty ||
//                 addressController.text.isEmpty ||
//                 phoneNumberController.text.isEmpty ||
//                 mobileNumberController.text.isEmpty ||
//                 selectedLocation == null) {
//               Get.snackbar(
//                 'ثبت ناموفق',
//                 'لطفاً تمام اطلاعات را کامل کنید.',
//                 backgroundColor: Colors.red,
//               );
//             } else {
//               controller.addSupplier(
//                 Supplier(
//                   id: '',
//                   collectionId: '',
//                   collectionName: '',
//                   companyName: companyNameController.text,
//                   phoneNumber: phoneNumberController.text,
//                   mobileNumber: mobileNumberController.text,
//                   address: addressController.text,
//                   location: '${selectedLocation!.latitude},${selectedLocation!.longitude}',
//                 ),
//               );
//               Get.snackbar(
//                 'ثبت موفق',
//                 'ثبت تامین کننده با موفقیت انجام شد.',
//                 backgroundColor: Colors.green,
//               );
//               Navigator.of(context).pop();
//             }
//           },
//           child: Text('ثبت شرکت'),
//         ),
//       ],
//     );
//   }
// }

// class AddSupplierDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final SupplierController controller = Get.find();
//     final companyNameController = TextEditingController();
//     final addressController = TextEditingController();
//     final phoneNumberController = TextEditingController();
//     final mobileNumberController = TextEditingController();
//     LatLng? selectedLocation;
//
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         TextField(
//           controller: companyNameController,
//           decoration: InputDecoration(labelText: 'Company Name'),
//         ),
//         TextField(
//           controller: addressController,
//           decoration: InputDecoration(labelText: 'Address'),
//         ),
//         TextField(
//           controller: phoneNumberController,
//           decoration: InputDecoration(labelText: 'Phone Number'),
//         ),
//         TextField(
//           controller: mobileNumberController,
//           decoration: InputDecoration(labelText: 'Mobile Number'),
//         ),
//         SizedBox(height: 10),
//         ElevatedButton(
//           onPressed: () async {
//             selectedLocation = await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AddLocationDialog();
//               },
//             );
//           },
//           child: Text('Select Location'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (selectedLocation != null) {
//               controller.addSupplier(
//                 Supplier(
//                   id: '',
//                   collectionId: '',
//                   collectionName: '',
//                   companyName: companyNameController.text,
//                   phoneNumber: phoneNumberController.text,
//                   mobileNumber: mobileNumberController.text,
//                   address: addressController.text,
//                   location: '${selectedLocation!.latitude},${selectedLocation!.longitude}',
//                 ),
//               );
//               Navigator.of(context).pop();
//             } else {
//               // Handle case where no location is selected
//               print('No location selected');
//             }
//           },
//           child: Text('Add Supplier'),
//         ),
//       ],
//     );
//   }
// }


// مدل Location
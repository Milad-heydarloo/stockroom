// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:latlong2/latlong.dart';
// // import 'package:saaterco_buysell/BuySell_GetX/Supiller/Location_GetX/supplier_model.dart';
// // import 'package:saaterco_buysell/Drawer/MyDrawer.dart';
// //
// // import 'supplier_controller.dart';
// // import 'package:http/http.dart' as http;
// //
// // import 'package:geolocator/geolocator.dart';
// //
//
//
//
//
//
//
//
//
// // class AddSupplierDialog extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final SupplierController controller = Get.find();
// //     final companyNameController = TextEditingController();
// //     final addressController = TextEditingController();
// //     final phoneNumberController = TextEditingController();
// //     final mobileNumberController = TextEditingController();
// //     LatLng? selectedLocation;
// //
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         TextField(
// //           controller: companyNameController,
// //           decoration: InputDecoration(labelText: 'نام شرکت'),
// //         ),
// //         TextField(
// //           controller: addressController,
// //           decoration: InputDecoration(labelText: 'آدرس'),
// //         ),
// //         TextField(
// //           controller: phoneNumberController,
// //           decoration: InputDecoration(labelText: 'شماره تلفن'),
// //         ),
// //         TextField(
// //           controller: mobileNumberController,
// //           decoration: InputDecoration(labelText: 'شماره موبایل'),
// //         ),
// //         SizedBox(height: 10),
// //         ElevatedButton(
// //           onPressed: () async {
// //             selectedLocation = await showDialog(
// //               context: context,
// //               builder: (BuildContext context) {
// //                 return AddLocationDialog(); // فرض بر این است که دیالوگ انتخاب مکان دارید
// //               },
// //             );
// //           },
// //           child: Text('انتخاب مکان'),
// //         ),
// //         ElevatedButton(
// //           onPressed: () {
// //             if (companyNameController.text.isEmpty ||
// //                 addressController.text.isEmpty ||
// //                 phoneNumberController.text.isEmpty ||
// //                 mobileNumberController.text.isEmpty ||
// //                 selectedLocation == null) {
// //               Get.snackbar(
// //                 'ثبت ناموفق',
// //                 'لطفاً تمام اطلاعات را کامل کنید.',
// //                 backgroundColor: Colors.red,
// //               );
// //             } else {
// //               controller.addSupplier(
// //                 Supplier(
// //                   id: '',
// //                   collectionId: '',
// //                   collectionName: '',
// //                   companyName: companyNameController.text,
// //                   phoneNumber: phoneNumberController.text,
// //                   mobileNumber: mobileNumberController.text,
// //                   address: addressController.text,
// //                   location: '${selectedLocation!.latitude},${selectedLocation!.longitude}',
// //                 ),
// //               );
// //               Get.snackbar(
// //                 'ثبت موفق',
// //                 'ثبت تامین کننده با موفقیت انجام شد.',
// //                 backgroundColor: Colors.green,
// //               );
// //               Navigator.of(context).pop();
// //             }
// //           },
// //           child: Text('ثبت شرکت'),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
// // class AddSupplierDialog extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final SupplierController controller = Get.find();
// //     final companyNameController = TextEditingController();
// //     final addressController = TextEditingController();
// //     final phoneNumberController = TextEditingController();
// //     final mobileNumberController = TextEditingController();
// //     LatLng? selectedLocation;
// //
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         TextField(
// //           controller: companyNameController,
// //           decoration: InputDecoration(labelText: 'Company Name'),
// //         ),
// //         TextField(
// //           controller: addressController,
// //           decoration: InputDecoration(labelText: 'Address'),
// //         ),
// //         TextField(
// //           controller: phoneNumberController,
// //           decoration: InputDecoration(labelText: 'Phone Number'),
// //         ),
// //         TextField(
// //           controller: mobileNumberController,
// //           decoration: InputDecoration(labelText: 'Mobile Number'),
// //         ),
// //         SizedBox(height: 10),
// //         ElevatedButton(
// //           onPressed: () async {
// //             selectedLocation = await showDialog(
// //               context: context,
// //               builder: (BuildContext context) {
// //                 return AddLocationDialog();
// //               },
// //             );
// //           },
// //           child: Text('Select Location'),
// //         ),
// //         ElevatedButton(
// //           onPressed: () {
// //             if (selectedLocation != null) {
// //               controller.addSupplier(
// //                 Supplier(
// //                   id: '',
// //                   collectionId: '',
// //                   collectionName: '',
// //                   companyName: companyNameController.text,
// //                   phoneNumber: phoneNumberController.text,
// //                   mobileNumber: mobileNumberController.text,
// //                   address: addressController.text,
// //                   location: '${selectedLocation!.latitude},${selectedLocation!.longitude}',
// //                 ),
// //               );
// //               Navigator.of(context).pop();
// //             } else {
// //               // Handle case where no location is selected
// //               print('No location selected');
// //             }
// //           },
// //           child: Text('Add Supplier'),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
//
// // مدل Location
// // class Location {
// //   final String province;
// //   final String county;
// //   final String district;
// //   final String city;
// //   final String region;
// //   final String neighborhood;
// //   final String title;
// //   final String address;
// //   final String type;
// //   final String fclass;
// //   final List<double> coordinates;
// //
// //   Location({
// //     required this.province,
// //     required this.county,
// //     required this.district,
// //     required this.city,
// //     required this.region,
// //     required this.neighborhood,
// //     required this.title,
// //     required this.address,
// //     required this.type,
// //     required this.fclass,
// //     required this.coordinates,
// //   });
// //
// //   factory Location.fromJson(Map<String, dynamic> json) {
// //     return Location(
// //       province: json['province'] ?? '',
// //       county: json['county'] ?? '',
// //       district: json['district'] ?? '',
// //       city: json['city'] ?? '',
// //       region: json['region'] ?? '',
// //       neighborhood: json['neighborhood'] ?? '',
// //       title: json['title'] ?? '',
// //       address: json['address'] ?? '',
// //       type: json['type'] ?? '',
// //       fclass: json['fclass'] ?? '',
// //       coordinates: json.containsKey('geom') && json['geom'].containsKey('coordinates')
// //           ? List<double>.from(json['geom']['coordinates'])
// //           : [],
// //     );
// //   }
// // }
//
// // // دیالوگ برای افزودن موقعیت
// // class AddLocationDialog extends StatefulWidget {
// //   @override
// //   _AddLocationDialogState createState() => _AddLocationDialogState();
// // }
// //
// // class _AddLocationDialogState extends State<AddLocationDialog> {
// //   LatLng? selectedLocation;
// //   final TextEditingController _searchController = TextEditingController();
// //   double _zoom = 15;
// //   MapController _mapController = MapController();
// //   List<Location> _searchResults = [];
// //   final String apiKey = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1In0.eyJhdWQiOiIyODIxMyIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1IiwiaWF0IjoxNzIxOTQwODg3LCJuYmYiOjE3MjE5NDA4ODcsImV4cCI6MTcyNDUzMjg4Nywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.P-HVICCEemigM5vv_lYuxVogPRp3_Tpa1-6zJWONRJ9BfsWXKd4B6FPgnxmJg1wkSGOXc_GFFoeZuFrf9nRfJzwdofkbFbI9yrtWWMATW2PIY8zjd_2SoZ4O94HE-AfyPOO4Dq_V7TJV1xiGinIJdyFCCfMBAuxN-2p8etP5UF2R6r9gDqxXpeVXiHbDx2zB9nTpONG_rlCi26SJ4Y63rDhsAOppdW6v0bP8bF7wkcOJ_z2lwzaWpcOnvJ0uP0cnYc_y9MiINw_P0g79MWMV-ntFNaaj_LU5G_kvSb9y0uWbmFrPgLoEgRFkdkRK2OEAORd9b5ux_iJGnkYV39UHPQ'; // کلید API خود را وارد کنید
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCurrentLocation();
// //   }
// //
// //   Future<void> _getCurrentLocation() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;
// //
// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       return Future.error('Location services are disabled.');
// //     }
// //
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         return Future.error('Location permissions are denied');
// //       }
// //     }
// //
// //     if (permission == LocationPermission.deniedForever) {
// //       return Future.error('Location permissions are permanently denied, we cannot request permissions.');
// //     }
// //
// //     Position position = await Geolocator.getCurrentPosition();
// //     setState(() {
// //       selectedLocation = LatLng(position.latitude, position.longitude);
// //       _mapController.move(selectedLocation!, _zoom);
// //     });
// //   }
// //
// //
// //
// //
// //   Future<void> _searchLocation(String query) async {
// //     final url = Uri.parse('https://map.ir/search/v2/autocomplete');
// //     final response = await http.post(
// //       url,
// //       headers: {
// //         'Content-Type': 'application/json',
// //         'x-api-key': apiKey, // اطمینان حاصل کنید که apiKey را درست تنظیم کرده‌اید
// //       },
// //       body: jsonEncode({
// //         'text': query,
// //         // استفاده صحیح از کلید برای فیلتر
// //         '\$filter': 'city eq تهران' // باید به صورت String باشد و \ را برای جلوگیری از تداخل استفاده کنید
// //       }),
// //     );
// //
// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       if (data is Map && data.containsKey('value')) {
// //         setState(() {
// //           _searchResults = (data['value'] as List)
// //               .map((item) => Location.fromJson(item as Map<String, dynamic>))
// //               .toList();
// //         });
// //       } else {
// //         print('Unexpected data format');
// //       }
// //     } else {
// //       print('Failed to fetch search results');
// //       print('Status code: ${response.statusCode}');
// //       print('Response body: ${response.body}');
// //     }
// //   }
// //
// //   void _moveToLocation(double lat, double lon) {
// //     final newLocation = LatLng(lat, lon);
// //     setState(() {
// //       selectedLocation = newLocation;
// //       _mapController.move(newLocation, _zoom);
// //       _searchResults = [];
// //       _searchController.clear();
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       child: Stack(
// //         children: [
// //           FlutterMap(
// //             mapController: _mapController,
// //             options: MapOptions(
// //               minZoom: 9, // مقدار زوم مینیموم
// //               maxZoom: 18,
// //               center: selectedLocation ?? LatLng(35.7045368,51.4045376),
// //               zoom: _zoom,
// //               onTap: (tapPosition, point) {
// //                 setState(() {
// //                   selectedLocation = point;
// //                 });
// //               },
// //             ),
// //             children: [
// //               TileLayer(
// //                   urlTemplate:
// //                   "https://map.ir/shiveh/xyz/1.0.0/Shiveh:Shiveh@EPSG:3857@png/{z}/{x}/{y}.png"
// //                       "?x-api-key=${apiKey}"),
// //
// //               if (selectedLocation != null)
// //                 MarkerLayer(
// //                   markers: [
// //                     Marker(
// //                       point: selectedLocation!,
// //                       builder: (ctx) => Icon(
// //                         Icons.location_on,
// //                         color: Colors.red,
// //                         size: 40.0,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //             ],
// //           ),
// //           Positioned(
// //             top: 10,
// //             left: 10,
// //             right: 10,
// //             child: Column(
// //               children: [
// //                 TextField(
// //                   controller: _searchController,
// //                   decoration: InputDecoration(
// //                     hintText: 'Search Location',
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   onSubmitted: _searchLocation,
// //                   onChanged: (value) {
// //                     if (value.isEmpty) {
// //                       setState(() {
// //                         _searchResults = [];
// //                       });
// //                     }
// //                   },
// //                 ),
// //                 if (_searchResults.isNotEmpty)
// //                   Container(
// //                     color: Colors.white,
// //                     height: 200,
// //                     child: ListView.builder(
// //                       itemCount: _searchResults.length,
// //                       itemBuilder: (context, index) {
// //                         final result = _searchResults[index] as Location;
// //                         return ListTile(
// //                           title: Text(result.title),
// //                           subtitle: Text('${result.address} \nLat: ${result.coordinates[1_2]}, Lon: ${result.coordinates[0]}'),
// //                           onTap: () {
// //                             final lat = result.coordinates[1_2];
// //                             final lon = result.coordinates[0];
// //                             _moveToLocation(lat, lon);
// //                           },
// //                         );
// //                       },
// //                     ),
// //                   ),
// //
// //                 SizedBox(height: 10),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.end,
// //                   children: [
// //                     FloatingActionButton(
// //                       heroTag: 'zoom_in',
// //                       onPressed: () {
// //                         setState(() {
// //                           _zoom++;
// //
// //                           _mapController.move(_mapController.center, _zoom);
// //                         });
// //                       },
// //                       child: Icon(Icons.zoom_in),
// //                     ),
// //                     SizedBox(width: 10),
// //                     FloatingActionButton(
// //                       heroTag: 'zoom_out',
// //                       onPressed: () {
// //                         setState(() {
// //                           _zoom--;
// //                           print(_zoom);
// //                           _mapController.move(_mapController.center, _zoom);
// //                         });
// //                       },
// //                       child: Icon(Icons.zoom_out),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //           if (selectedLocation != null)
// //             Positioned(
// //               bottom: 10,
// //               left: 10,
// //               right: 10,
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop(selectedLocation);
// //                 },
// //                 child: Text('Select Location'),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
// // Helper function to parse location strings
// // LatLng parseLocation(String location) {
// //   final parts = location.split(',');
// //   if (parts.length == 2) {
// //     final latitude = double.tryParse(parts[0]);
// //     final longitude = double.tryParse(parts[1_2]);
// //     if (latitude != null && longitude != null) {
// //       return LatLng(latitude, longitude);
// //     }
// //   }
// //   return LatLng(0.0, 0.0); // Default or error value
// // }
//
//
//
// // صفحه‌ی انتخاب مکان
// // class AddLocationPage extends StatefulWidget {
// //   @override
// //   _AddLocationPageState createState() => _AddLocationPageState();
// // }
// //
// // class _AddLocationPageState extends State<AddLocationPage> {
// //   LatLng? selectedLocation;
// //   final TextEditingController _searchController = TextEditingController();
// //   double _zoom = 15;
// //   MapController _mapController = MapController();
// //   List<Location> _searchResults = [];
// //   final String apiKey = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1In0.eyJhdWQiOiIyODIxMyIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1IiwiaWF0IjoxNzIxOTQwODg3LCJuYmYiOjE3MjE5NDA4ODcsImV4cCI6MTcyNDUzMjg4Nywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.P-HVICCEemigM5vv_lYuxVogPRp3_Tpa1-6zJWONRJ9BfsWXKd4B6FPgnxmJg1wkSGOXc_GFFoeZuFrf9nRfJzwdofkbFbI9yrtWWMATW2PIY8zjd_2SoZ4O94HE-AfyPOO4Dq_V7TJV1xiGinIJdyFCCfMBAuxN-2p8etP5UF2R6r9gDqxXpeVXiHbDx2zB9nTpONG_rlCi26SJ4Y63rDhsAOppdW6v0bP8bF7wkcOJ_z2lwzaWpcOnvJ0uP0cnYc_y9MiINw_P0g79MWMV-ntFNaaj_LU5G_kvSb9y0uWbmFrPgLoEgRFkdkRK2OEAORd9b5ux_iJGnkYV39UHPQ'; // کلید API خود را وارد کنید
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCurrentLocation();
// //   }
// //
// //
// //
// //   Future<void> _searchLocation(String query) async {
// //     final url = Uri.parse('https://map.ir/search/v2/autocomplete');
// //     final response = await http.post(
// //       url,
// //       headers: {
// //         'Content-Type': 'application/json',
// //         'x-api-key': apiKey, // اطمینان حاصل کنید که apiKey را درست تنظیم کرده‌اید
// //       },
// //       body: jsonEncode({
// //         'text': query,
// //         // استفاده صحیح از کلید برای فیلتر
// //         '\$filter': 'city eq تهران' // باید به صورت String باشد و \ را برای جلوگیری از تداخل استفاده کنید
// //       }),
// //     );
// //
// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       if (data is Map && data.containsKey('value')) {
// //         setState(() {
// //           _searchResults = (data['value'] as List)
// //               .map((item) => Location.fromJson(item as Map<String, dynamic>))
// //               .toList();
// //         });
// //       } else {
// //         print('Unexpected data format');
// //       }
// //     } else {
// //       print('Failed to fetch search results');
// //       print('Status code: ${response.statusCode}');
// //       print('Response body: ${response.body}');
// //     }
// //   }
// //
// //   void _moveToLocation(double lat, double lon) {
// //     final newLocation = LatLng(lat, lon);
// //     setState(() {
// //       selectedLocation = newLocation;
// //       _mapController.move(newLocation, _zoom);
// //       _searchResults = [];
// //       _searchController.clear();
// //     });
// //   }
// //   Future<void> _getCurrentLocation() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;
// //
// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       return Future.error('Location services are disabled.');
// //     }
// //
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         return Future.error('Location permissions are denied');
// //       }
// //     }
// //
// //     if (permission == LocationPermission.deniedForever) {
// //       return Future.error('Location permissions are permanently denied, we cannot request permissions.');
// //     }
// //
// //     Position position = await Geolocator.getCurrentPosition();
// //     setState(() {
// //       selectedLocation = LatLng(position.latitude, position.longitude);
// //       _mapController.move(selectedLocation!, _zoom);
// //     });
// //   }
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('انتخاب مکان'),
// //       ),
// //       body: Stack(
// //         children: [
// //           FlutterMap(
// //             mapController: _mapController,
// //             options: MapOptions(
// //               minZoom: 9, // مقدار زوم مینیموم
// //               maxZoom: 18,
// //               center: selectedLocation ?? LatLng(35.7045368,51.4045376),
// //               zoom: _zoom,
// //               onTap: (tapPosition, point) {
// //                 setState(() {
// //                   selectedLocation = point;
// //                 });
// //               },
// //             ),
// //             children: [
// //               TileLayer(
// //                   urlTemplate:
// //                   "https://map.ir/shiveh/xyz/1.0.0/Shiveh:Shiveh@EPSG:3857@png/{z}/{x}/{y}.png"
// //                       "?x-api-key=${apiKey}"),
// //
// //               if (selectedLocation != null)
// //                 MarkerLayer(
// //                   markers: [
// //                     Marker(
// //                       point: selectedLocation!,
// //                       builder: (ctx) => Icon(
// //                         Icons.location_on,
// //                         color: Colors.red,
// //                         size: 40.0,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //             ],
// //           ),
// //           Positioned(
// //             top: 10,
// //             left: 10,
// //             right: 10,
// //             child: Column(
// //               children: [
// //                 TextField(
// //                   controller: _searchController,
// //                   decoration: InputDecoration(
// //                     hintText: 'جستجوی مکان',
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   onSubmitted: _searchLocation,
// //                 ),
// //                 if (_searchResults.isNotEmpty)
// //                   Container(
// //                     color: Colors.white,
// //                     height: 200,
// //                     child: ListView.builder(
// //                       itemCount: _searchResults.length,
// //                       itemBuilder: (context, index) {
// //                         final result = _searchResults[index];
// //                         return ListTile(
// //                           title: Text(result.title),
// //                           subtitle: Text('${result.address} \nLat: ${result.coordinates[1_2]}, Lon: ${result.coordinates[0]}'),
// //                           onTap: () {
// //                             _moveToLocation(result.coordinates[1_2], result.coordinates[0]);
// //                           },
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 SizedBox(height: 10),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.end,
// //                   children: [
// //                     FloatingActionButton(
// //                       onPressed: () {
// //                         setState(() {
// //                           _zoom++;
// //                           _mapController.move(_mapController.center, _zoom);
// //                         });
// //                       },
// //                       child: Icon(Icons.zoom_in),
// //                     ),
// //                     SizedBox(width: 10),
// //                     FloatingActionButton(
// //                       onPressed: () {
// //                         setState(() {
// //                           _zoom--;
// //                           _mapController.move(_mapController.center, _zoom);
// //                         });
// //                       },
// //                       child: Icon(Icons.zoom_out),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //           // if (selectedLocation != null)
// //           //   Positioned(
// //           //     bottom: 10,
// //           //     left: 10,
// //           //     right: 10,
// //           //     child: ElevatedButton(
// //           //       onPressed: () {
// //           //         Navigator.of(context).pop(selectedLocation);
// //           //       },
// //           //       child: Text('انتخاب مکان'),
// //           //     ),
// //           //   ),
// //           if (selectedLocation != null)
// //             Positioned(
// //               bottom: 10,
// //               right: 10,
// //               child: FloatingActionButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop(selectedLocation);
// //                 },
// //                 child: Icon(Icons.check),
// //                 backgroundColor: Colors.green,
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// //
// // class AddSupplierDialog extends StatefulWidget {
// //   @override
// //   _AddSupplierDialogState createState() => _AddSupplierDialogState();
// // }
// //
// // class _AddSupplierDialogState extends State<AddSupplierDialog> {
// //   final SupplierController controller = Get.find();
// //   final TextEditingController companyNameController = TextEditingController();
// //   final TextEditingController addressController = TextEditingController();
// //   final TextEditingController phoneNumberController = TextEditingController();
// //   final TextEditingController mobileNumberController = TextEditingController();
// //   Location? selectedLocation;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog.fullscreen(
// //       backgroundColor: Colors.transparent,
// //
// //       child:Center(child: Container(
// //         padding: EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: Colors.white, // رنگ پس‌زمینه داخل دیالوگ
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Column(
// //
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             TextField(
// //               controller: companyNameController,
// //               decoration: InputDecoration(labelText: 'نام شرکت'),
// //             ),
// //             TextField(
// //               controller: addressController,
// //               decoration: InputDecoration(labelText: 'آدرس'),
// //             ),
// //             TextField(
// //               controller: phoneNumberController,
// //               decoration: InputDecoration(labelText: 'شماره تلفن'),
// //             ),
// //             TextField(
// //               controller: mobileNumberController,
// //               decoration: InputDecoration(labelText: 'شماره موبایل'),
// //             ),
// //             SizedBox(height: 10),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 LatLng? selectedLatLng = await Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => AddLocationPage()),
// //                 );
// //                 if (selectedLatLng != null) {
// //                   setState(() {
// //                     selectedLocation = Location(
// //                       province: '',
// //                       county: '',
// //                       district: '',
// //                       city: '',
// //                       region: '',
// //                       neighborhood: '',
// //                       title: 'مکان انتخاب شده',
// //                       address: '',
// //                       type: '',
// //                       fclass: '',
// //                       coordinates: [selectedLatLng.latitude, selectedLatLng.longitude],
// //                     );
// //                   });
// //                 }
// //               },
// //               child: Text('انتخاب مکان'),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 if (companyNameController.text.isEmpty ||
// //                     addressController.text.isEmpty ||
// //                     phoneNumberController.text.isEmpty ||
// //                     mobileNumberController.text.isEmpty ||
// //                     selectedLocation == null) {
// //                   Get.snackbar(
// //                     'ثبت ناموفق',
// //                     'لطفاً تمام اطلاعات را کامل کنید.',
// //                     backgroundColor: Colors.red,
// //                   );
// //                 } else {
// //                   controller.addSupplier(
// //                     Supplier(
// //                       id: '',
// //                       collectionId: '',
// //                       collectionName: '',
// //                       companyName: companyNameController.text,
// //                       phoneNumber: phoneNumberController.text,
// //                       mobileNumber: mobileNumberController.text,
// //                       address: addressController.text,
// //                       location: '${selectedLocation!.coordinates[0]},${selectedLocation!.coordinates[1_2]}',
// //                     ),
// //                   );
// //                   Get.snackbar(
// //                     'ثبت موفق',
// //                     'ثبت نام با موفقیت انجام شد.',
// //                     backgroundColor: Colors.green,
// //                   );
// //                   Navigator.of(context).pop();
// //                 }
// //               },
// //               child: Text('ثبت شرکت'),
// //             ),
// //           ],
// //         ),),),
// //     );
// //   }
// // }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:sqflite/sqflite.dart';
// // import 'package:path/path.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Inventory Management',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: HomePage(),
// //     );
// //   }
// // }
// //
// // class HomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Inventory Management'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => PurchaseSalesPage()),
// //                 );
// //               },
// //               child: Text('Purchase & Sales'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => InventoryPage()),
// //                 );
// //               },
// //               child: Text('Inventory Management'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => AccountingPage()),
// //                 );
// //               },
// //               child: Text('Accounting'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // Purchase & Sales Page
// // class PurchaseSalesPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Purchase & Sales'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => PurchasePage()),
// //                 );
// //               },
// //               child: Text('Register Purchase Order'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => SalesPage()),
// //                 );
// //               },
// //               child: Text('Register Sales Order'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // Purchase Order Registration
// // class PurchasePage extends StatelessWidget {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _storeNameController = TextEditingController();
// //   final TextEditingController _contactNumberController = TextEditingController();
// //   final TextEditingController _addressController = TextEditingController();
// //   final TextEditingController _itemNameController = TextEditingController();
// //   final TextEditingController _warrantyController = TextEditingController();
// //   final TextEditingController _quantityController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Purchase Order'),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: <Widget>[
// //               TextFormField(
// //                 controller: _storeNameController,
// //                 decoration: InputDecoration(labelText: 'Store Name'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the store name';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _contactNumberController,
// //                 decoration: InputDecoration(labelText: 'Contact Number'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the contact number';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _addressController,
// //                 decoration: InputDecoration(labelText: 'Address'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the address';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _itemNameController,
// //                 decoration: InputDecoration(labelText: 'Item Name'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the item name';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _warrantyController,
// //                 decoration: InputDecoration(labelText: 'Warranty'),
// //               ),
// //               TextFormField(
// //                 controller: _quantityController,
// //                 decoration: InputDecoration(labelText: 'Quantity'),
// //                 keyboardType: TextInputType.number,
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the quantity';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   if (_formKey.currentState!.validate()) {
// //                     await DatabaseHelper.instance.insertPurchaseOrder(
// //                       PurchaseOrder(
// //                         storeName: _storeNameController.text,
// //                         contactNumber: _contactNumberController.text,
// //                         address: _addressController.text,
// //                         itemName: _itemNameController.text,
// //                         warranty: _warrantyController.text,
// //                         quantity: int.parse(_quantityController.text),
// //                         orderDate: DateTime.now().toString(),
// //                       ),
// //                     );
// //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                       content: Text('Purchase Order Registered'),
// //                     ));
// //                   }
// //                 },
// //                 child: Text('Submit'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // Sales Order Registration
// // class SalesPage extends StatelessWidget {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _storeNameController = TextEditingController();
// //   final TextEditingController _contactNumberController = TextEditingController();
// //   final TextEditingController _addressController = TextEditingController();
// //   final TextEditingController _itemNameController = TextEditingController();
// //   final TextEditingController _warrantyController = TextEditingController();
// //   final TextEditingController _quantityController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Sales Order'),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: <Widget>[
// //               TextFormField(
// //                 controller: _storeNameController,
// //                 decoration: InputDecoration(labelText: 'Store Name'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the store name';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _contactNumberController,
// //                 decoration: InputDecoration(labelText: 'Contact Number'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the contact number';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _addressController,
// //                 decoration: InputDecoration(labelText: 'Address'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the address';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _itemNameController,
// //                 decoration: InputDecoration(labelText: 'Item Name'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the item name';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _warrantyController,
// //                 decoration: InputDecoration(labelText: 'Warranty'),
// //               ),
// //               TextFormField(
// //                 controller: _quantityController,
// //                 decoration: InputDecoration(labelText: 'Quantity'),
// //                 keyboardType: TextInputType.number,
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the quantity';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   if (_formKey.currentState!.validate()) {
// //                     await DatabaseHelper.instance.insertSalesOrder(
// //                       SalesOrder(
// //                         storeName: _storeNameController.text,
// //                         contactNumber: _contactNumberController.text,
// //                         address: _addressController.text,
// //                         itemName: _itemNameController.text,
// //                         warranty: _warrantyController.text,
// //                         quantity: int.parse(_quantityController.text),
// //                         orderDate: DateTime.now().toString(),
// //                       ),
// //                     );
// //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                       content: Text('Sales Order Registered'),
// //                     ));
// //                   }
// //                 },
// //                 child: Text('Submit'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // Inventory Management Page
// // class InventoryPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Inventory Management'),
// //       ),
// //       body: FutureBuilder<List<Inventory>>(
// //         future: DatabaseHelper.instance.getInventory(),
// //         builder: (BuildContext context, AsyncSnapshot<List<Inventory>> snapshot) {
// //           if (!snapshot.hasData) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //           return ListView(
// //             children: snapshot.data!.map((inventory) {
// //               return ListTile(
// //                 title: Text(inventory.itemName),
// //                 subtitle: Text('Quantity: ${inventory.quantityInStock}'),
// //               );
// //             }).toList(),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // // Accounting Page
// // class AccountingPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Accounting'),
// //       ),
// //       body: FutureBuilder<List<Accounting>>(
// //         future: DatabaseHelper.instance.getAccounting(),
// //         builder: (BuildContext context, AsyncSnapshot<List<Accounting>> snapshot) {
// //           if (!snapshot.hasData) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //           return ListView(
// //             children: snapshot.data!.map((accounting) {
// //               return ListTile(
// //                 title: Text('Order ID: ${accounting.orderId}'),
// //                 subtitle: Text('Type: ${accounting.orderType}, Status: ${accounting.status}'),
// //                 trailing: Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: <Widget>[
// //                     IconButton(
// //                       icon: Icon(Icons.check),
// //                       onPressed: () async {
// //                         await DatabaseHelper.instance.updateAccountingStatus(accounting.id!, 'Approved');
// //                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                           content: Text('Order Approved'),
// //                         ));
// //                       },
// //                     ),
// //                     IconButton(
// //                       icon: Icon(Icons.clear),
// //                       onPressed: () async {
// //                         await DatabaseHelper.instance.updateAccountingStatus(accounting.id!, 'Rejected');
// //                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                           content: Text('Order Rejected'),
// //                         ));
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             }).toList(),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // // Database Helper
// // class DatabaseHelper {
// //   static final DatabaseHelper instance = DatabaseHelper._init();
// //   static Database? _database;
// //
// //   DatabaseHelper._init();
// //
// //   Future<Database> get database async {
// //     if (_database != null) return _database!;
// //     _database = await _initDB('app_database.db');
// //     return _database!;
// //   }
// //
// //   Future<Database> _initDB(String filePath) async {
// //     final dbPath = await getDatabasesPath();
// //     final path = join(dbPath, filePath);
// //     return await openDatabase(
// //       path,
// //       version: 1_2,
// //       onCreate: _createDB,
// //     );
// //   }
// //
// //   Future _createDB(Database db, int version) async {
// //     await db.execute('''
// //       CREATE TABLE purchase_orders (
// //         id INTEGER PRIMARY KEY AUTOINCREMENT,
// //         store_name TEXT,
// //         contact_number TEXT,
// //         address TEXT,
// //         item_name TEXT,
// //         warranty TEXT,
// //         quantity INTEGER,
// //         order_date TEXT
// //       )
// //     ''');
// //     await db.execute('''
// //       CREATE TABLE sales_orders (
// //         id INTEGER PRIMARY KEY AUTOINCREMENT,
// //         store_name TEXT,
// //         contact_number TEXT,
// //         address TEXT,
// //         item_name TEXT,
// //         warranty TEXT,
// //         quantity INTEGER,
// //         order_date TEXT
// //       )
// //     ''');
// //     await db.execute('''
// //       CREATE TABLE inventory (
// //         item_name TEXT PRIMARY KEY,
// //         quantity_in_stock INTEGER
// //       )
// //     ''');
// //     await db.execute('''
// //       CREATE TABLE accounting (
// //         id INTEGER PRIMARY KEY AUTOINCREMENT,
// //         order_id INTEGER,
// //         order_type TEXT,
// //         status TEXT
// //       )
// //     ''');
// //   }
// //
// //   // Insert Purchase Order
// //   Future<int> insertPurchaseOrder(PurchaseOrder order) async {
// //     final db = await instance.database;
// //     await db.insert('purchase_orders', order.toMap());
// //     return db.rawUpdate('''
// //       INSERT INTO inventory(item_name, quantity_in_stock)
// //       VALUES(?, ?)
// //       ON CONFLICT(item_name) DO UPDATE SET quantity_in_stock = quantity_in_stock + ?;
// //     ''', [order.itemName, order.quantity, order.quantity]);
// //   }
// //
// //   // Insert Sales Order
// //   Future<int> insertSalesOrder(SalesOrder order) async {
// //     final db = await instance.database;
// //     await db.insert('sales_orders', order.toMap());
// //     return db.rawUpdate('''
// //       INSERT INTO inventory(item_name, quantity_in_stock)
// //       VALUES(?, ?)
// //       ON CONFLICT(item_name) DO UPDATE SET quantity_in_stock = quantity_in_stock - ?;
// //     ''', [order.itemName, -order.quantity, order.quantity]);
// //   }
// //
// //   // Get Inventory
// //   Future<List<Inventory>> getInventory() async {
// //     final db = await instance.database;
// //     final maps = await db.query('inventory');
// //     return List.generate(maps.length, (i) {
// //       return Inventory(
// //         itemName: maps[i]['item_name'] as String, // Convert to String
// //         quantityInStock: maps[i]['quantity_in_stock'] as int, // Convert to int
// //       );
// //     });
// //   }
// //
// //   // Get Accounting
// //   Future<List<Accounting>> getAccounting() async {
// //     final db = await instance.database;
// //     final maps = await db.query('accounting');
// //     return List.generate(maps.length, (i) {
// //       return Accounting(
// //         id: maps[i]['id'] as int?, // Convert to int?
// //         orderId: maps[i]['order_id'] as int, // Convert to int
// //         orderType: maps[i]['order_type'] as String, // Convert to String
// //         status: maps[i]['status'] as String, // Convert to String
// //       );
// //     });
// //   }
// //
// //   // Update Accounting Status
// //   Future<int> updateAccountingStatus(int id, String status) async {
// //     final db = await instance.database;
// //     return db.update('accounting', {'status': status}, where: 'id = ?', whereArgs: [id]);
// //   }
// // }
// //
// // // Models
// // class PurchaseOrder {
// //   final int? id;
// //   final String storeName;
// //   final String contactNumber;
// //   final String address;
// //   final String itemName;
// //   final String warranty;
// //   final int quantity;
// //   final String orderDate;
// //
// //   PurchaseOrder({
// //     this.id,
// //     required this.storeName,
// //     required this.contactNumber,
// //     required this.address,
// //     required this.itemName,
// //     required this.warranty,
// //     required this.quantity,
// //     required this.orderDate,
// //   });
// //
// //   factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
// //     return PurchaseOrder(
// //       id: map['id'] as int?,
// //       storeName: map['store_name'] as String,
// //       contactNumber: map['contact_number'] as String,
// //       address: map['address'] as String,
// //       itemName: map['item_name'] as String,
// //       warranty: map['warranty'] as String,
// //       quantity: map['quantity'] as int,
// //       orderDate: map['order_date'] as String,
// //     );
// //   }
// //
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'id': id,
// //       'store_name': storeName,
// //       'contact_number': contactNumber,
// //       'address': address,
// //       'item_name': itemName,
// //       'warranty': warranty,
// //       'quantity': quantity,
// //       'order_date': orderDate,
// //     };
// //   }
// // }
// //
// //
// // class SalesOrder {
// //   final int? id;
// //   final String storeName;
// //   final String contactNumber;
// //   final String address;
// //   final String itemName;
// //   final String warranty;
// //   final int quantity;
// //   final String orderDate;
// //
// //   SalesOrder({
// //     this.id,
// //     required this.storeName,
// //     required this.contactNumber,
// //     required this.address,
// //     required this.itemName,
// //     required this.warranty,
// //     required this.quantity,
// //     required this.orderDate,
// //   });
// //
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'store_name': storeName,
// //       'contact_number': contactNumber,
// //       'address': address,
// //       'item_name': itemName,
// //       'warranty': warranty,
// //       'quantity': quantity,
// //       'order_date': orderDate,
// //     };
// //   }
// // }
// //
// // class Inventory {
// //   final String itemName;
// //   final int quantityInStock;
// //
// //   Inventory({
// //     required this.itemName,
// //     required this.quantityInStock,
// //   });
// // }
// //
// // class Accounting {
// //   final int? id;
// //   final int orderId;
// //   final String orderType;
// //   final String status;
// //
// //   Accounting({
// //     this.id,
// //     required this.orderId,
// //     required this.orderType,
// //     required this.status,
// //   });
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'مدیریت فروشگاه',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(), // صفحه اصلی برنامه
//     );
//   }
// }
//
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('مدیریت فروشگاه'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Get.to(() => OrderPage()); // انتقال به صفحه سفارشات
//               },
//               child: Text('مدیریت سفارشات'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Get.to(() => InventoryPage()); // انتقال به صفحه انبار
//               },
//               child: Text('مدیریت انبار'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Get.to(() => AccountingPage()); // انتقال به صفحه حسابداری
//               },
//               child: Text('مدیریت حسابداری'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class AddOrderPage extends StatelessWidget {
//   final OrderController orderController = Get.find();
//
//   final TextEditingController storeNameController = TextEditingController();
//   final TextEditingController contactNumberController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController itemNameController = TextEditingController();
//   final TextEditingController warrantyController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('افزودن سفارش'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: storeNameController,
//               decoration: InputDecoration(labelText: 'نام فروشگاه'),
//             ),
//             TextField(
//               controller: contactNumberController,
//               decoration: InputDecoration(labelText: 'شماره تماس'),
//             ),
//             TextField(
//               controller: addressController,
//               decoration: InputDecoration(labelText: 'آدرس'),
//             ),
//             TextField(
//               controller: itemNameController,
//               decoration: InputDecoration(labelText: 'نام کالا'),
//             ),
//             TextField(
//               controller: warrantyController,
//               decoration: InputDecoration(labelText: 'گارانتی'),
//             ),
//             TextField(
//               controller: quantityController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'تعداد'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final order = PurchaseOrder(
//                   storeName: storeNameController.text,
//                   contactNumber: contactNumberController.text,
//                   address: addressController.text,
//                   itemName: itemNameController.text,
//                   warranty: warrantyController.text,
//                   quantity: int.tryParse(quantityController.text) ?? 0,
//                   orderDate: DateTime.now().toString(),
//                 );
//                 orderController.addPurchaseOrder(order);
//                 Get.back(); // برگرداندن به صفحه قبلی بعد از ذخیره
//               },
//               child: Text('ذخیره'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class AccountingPage extends StatelessWidget {
//   final AccountingController accountingController = Get.put(AccountingController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('حسابداری'),
//       ),
//       body: GetBuilder<AccountingController>(
//         builder: (_) {
//           return ListView.builder(
//             itemCount: accountingController.accountingList.length,
//             itemBuilder: (context, index) {
//               final accounting = accountingController.accountingList[index];
//               return ListTile(
//                 title: Text('شناسه سفارش: ${accounting.orderId}'),
//                 subtitle: Text('نوع: ${accounting.orderType}, وضعیت: ${accounting.status}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.check),
//                       onPressed: () {
//                         accountingController.approveOrder(accounting.id);
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.clear),
//                       onPressed: () {
//                         accountingController.rejectOrder(accounting.id);
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class InventoryPage extends StatelessWidget {
//   final InventoryController inventoryController = Get.put(InventoryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('مدیریت انبار'),
//       ),
//       body: GetBuilder<InventoryController>(
//         builder: (_) {
//           return ListView.builder(
//             itemCount: inventoryController.inventoryList.length,
//             itemBuilder: (context, index) {
//               final inventory = inventoryController.inventoryList[index];
//               return ListTile(
//                 title: Text(inventory.itemName),
//                 subtitle: Text('موجودی: ${inventory.quantityInStock}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
//
// class OrderPage extends StatelessWidget {
//   final OrderController orderController = Get.put(OrderController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('مدیریت سفارشات'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Get.to(() => AddOrderPage()); // انتقال به صفحه افزودن سفارش
//             },
//             child: Text('افزودن سفارش خرید'),
//           ),
//           GetBuilder<OrderController>(
//             builder: (_) {
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: orderController.purchaseOrders.length,
//                   itemBuilder: (context, index) {
//                     final order = orderController.purchaseOrders[index];
//                     return ListTile(
//                       title: Text(order.itemName),
//                       subtitle: Text('تعداد: ${order.quantity}'),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AccountingController extends GetxController {
//   final GetStorage _box = GetStorage();
//
//   List<Accounting> get accountingList {
//     final data = _box.read<List>('accountingList') ?? [];
//     return data.map((item) => Accounting.fromJson(item)).toList();
//   }
//
//   void setAccounting(List<Accounting> accounting) {
//     _box.write('accountingList', accounting.map((e) => e.toJson()).toList());
//     update();
//   }
//
//   void approveOrder(int id) {
//     final index = accountingList.indexWhere((acc) => acc.id == id);
//     if (index != -1) {
//       final updated = accountingList;
//       updated[index].status = 'Approved';
//       _box.write('accountingList', updated.map((e) => e.toJson()).toList());
//       update();
//     }
//   }
//
//   void rejectOrder(int id) {
//     final index = accountingList.indexWhere((acc) => acc.id == id);
//     if (index != -1) {
//       final updated = accountingList;
//       updated[index].status = 'Rejected';
//       _box.write('accountingList', updated.map((e) => e.toJson()).toList());
//       update();
//     }
//   }
// }
//
//
// class InventoryController extends GetxController {
//   final GetStorage _box = GetStorage();
//
//   List<Inventory> get inventoryList {
//     final data = _box.read<List>('inventoryList') ?? [];
//     return data.map((item) => Inventory.fromJson(item)).toList();
//   }
//
//   void setInventory(List<Inventory> inventory) {
//     _box.write('inventoryList', inventory.map((e) => e.toJson()).toList());
//     update();
//   }
// }
//
//
//
// class OrderController extends GetxController {
//   final GetStorage _box = GetStorage();
//
//   List<PurchaseOrder> get purchaseOrders {
//     final data = _box.read<List>('purchaseOrders') ?? [];
//     return data.map((item) => PurchaseOrder.fromJson(item)).toList();
//   }
//
//   List<PurchaseOrder> get salesOrders {
//     final data = _box.read<List>('salesOrders') ?? [];
//     return data.map((item) => PurchaseOrder.fromJson(item)).toList();
//   }
//
//   void addPurchaseOrder(PurchaseOrder order) {
//     final orders = purchaseOrders;
//     orders.add(order);
//     _box.write('purchaseOrders', orders.map((e) => e.toJson()).toList());
//     update();
//   }
//
//   void addSalesOrder(PurchaseOrder order) {
//     final orders = salesOrders;
//     orders.add(order);
//     _box.write('salesOrders', orders.map((e) => e.toJson()).toList());
//     update();
//   }
// }
//
//
// class PurchaseOrder {
//   String storeName;
//   String contactNumber;
//   String address;
//   String itemName;
//   String warranty;
//   int quantity;
//   String orderDate;
//
//   PurchaseOrder({
//     required this.storeName,
//     required this.contactNumber,
//     required this.address,
//     required this.itemName,
//     required this.warranty,
//     required this.quantity,
//     required this.orderDate,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'storeName': storeName,
//     'contactNumber': contactNumber,
//     'address': address,
//     'itemName': itemName,
//     'warranty': warranty,
//     'quantity': quantity,
//     'orderDate': orderDate,
//   };
//
//   static PurchaseOrder fromJson(Map<String, dynamic> json) => PurchaseOrder(
//     storeName: json['storeName'],
//     contactNumber: json['contactNumber'],
//     address: json['address'],
//     itemName: json['itemName'],
//     warranty: json['warranty'],
//     quantity: json['quantity'],
//     orderDate: json['orderDate'],
//   );
// }
//
// class Inventory {
//   String itemName;
//   int quantityInStock;
//
//   Inventory({
//     required this.itemName,
//     required this.quantityInStock,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'itemName': itemName,
//     'quantityInStock': quantityInStock,
//   };
//
//   static Inventory fromJson(Map<String, dynamic> json) => Inventory(
//     itemName: json['itemName'],
//     quantityInStock: json['quantityInStock'],
//   );
// }
//
// class Accounting {
//   int id;
//   int orderId;
//   String orderType;
//   String status;
//
//   Accounting({
//     required this.id,
//     required this.orderId,
//     required this.orderType,
//     required this.status,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'orderId': orderId,
//     'orderType': orderType,
//     'status': status,
//   };
//
//   static Accounting fromJson(Map<String, dynamic> json) => Accounting(
//     id: json['id'],
//     orderId: json['orderId'],
//     orderType: json['orderType'],
//     status: json['status'],
//   );
// }
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:project/BuySell_GetX/Supiller/Location_GetX/supplier_model.dart';
import 'package:project/Drawer/MyDrawer.dart';


import 'supplier_controller.dart';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';



class SupplierListScreens extends StatefulWidget {
  const SupplierListScreens({Key? key}) : super(key: key);

  @override
  State<SupplierListScreens> createState() => _SupplierListScreensState();
}

class _SupplierListScreensState extends State<SupplierListScreens> {
  final SupplierController controller = Get.put(SupplierController());
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  Location? selectedLocation;
  @override
  Widget build(BuildContext context) {
    final SupplierController controller = Get.find<SupplierController>();

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('تامین کننده')),
      body: GetBuilder<SupplierController>(
        initState: (state) async {
       await  controller.fetchSuppliers();
        },
        builder: (controller) {
          if (controller.suppliers.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: controller.suppliers.length,
              itemBuilder: (context, index) {
                final supplier = controller.suppliers[index];
                final location = parseLocation(supplier.location);

                return Card(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 150,
                          child: FlutterMap(
                            options: MapOptions(
                              center: location,
                              zoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c'],
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: location,
                                    builder: (ctx) => Container(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                supplier.companyName,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("Address: ${supplier.address}"),
                              Text("Phone: ${supplier.phoneNumber}"),
                              Text("Mobile: ${supplier.mobileNumber}"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showEditOrderDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditOrderDialog(BuildContext context) {

    showDialog(

      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(

          backgroundColor: Colors.white,
          title: const Text('ثبت تامیین کننده'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SingleChildScrollView(
                child:Column(

                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 500,),
                    TextField(
                      controller: companyNameController,
                      decoration: InputDecoration(labelText: 'نام شرکت'),
                    ),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: 'آدرس'),
                    ),
                    TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(labelText: 'شماره تلفن'),
                    ),
                    TextField(
                      controller: mobileNumberController,
                      decoration: InputDecoration(labelText: 'شماره موبایل'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        LatLng? selectedLatLng = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddLocationPage()),
                        );
                        if (selectedLatLng != null) {
                          setState(() {
                            selectedLocation = Location(
                              province: '',
                              county: '',
                              district: '',
                              city: '',
                              region: '',
                              neighborhood: '',
                              title: 'مکان انتخاب شده',
                              address: '',
                              type: '',
                              fclass: '',
                              coordinates: [selectedLatLng.latitude, selectedLatLng.longitude],
                            );
                          });
                        }
                      },
                      child: Text('انتخاب مکان'),
                    ),
                    SizedBox(height: 20),

                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed:() {
                companyNameController.clear();
                addressController.clear();
                phoneNumberController.clear();
                mobileNumberController.clear();
                setState(() {
                  selectedLocation = null;
                });

                Navigator.of(context).pop();
              },
              child: const Text('کنسل'),
            ),

            ElevatedButton(
              onPressed: () {
                if (companyNameController.text.isEmpty ||
                    addressController.text.isEmpty ||
                    phoneNumberController.text.isEmpty ||
                    mobileNumberController.text.isEmpty ||
                    selectedLocation == null) {
                  Get.snackbar(
                    'ثبت ناموفق',
                    'لطفاً تمام اطلاعات را کامل کنید.',
                    backgroundColor: Colors.red,
                  );
                } else {
                  controller.addSupplier(
                    Supplier(
                      id: '',
                      collectionId: '',
                      collectionName: '',
                      companyName: companyNameController.text,
                      phoneNumber: phoneNumberController.text,
                      mobileNumber: mobileNumberController.text,
                      address: addressController.text,
                      location: '${selectedLocation!.coordinates[0]},${selectedLocation!.coordinates[1]}',
                    ),
                  );
                  Get.snackbar(
                    'ثبت موفق',
                    'ثبت نام با موفقیت انجام شد.',
                    backgroundColor: Colors.green,
                  );

                  // پاکسازی فیلدهای متنی و مکان انتخاب شده
                  companyNameController.clear();
                  addressController.clear();
                  phoneNumberController.clear();
                  mobileNumberController.clear();
                  setState(() {
                    selectedLocation = null;
                  });

                  Navigator.of(context).pop();
                }

              },
              child: const Text('ثبت تامیین کننده'),
            ),
          ],
        ),
      ),
    );
  }
}





class Location {
  final String province;
  final String county;
  final String district;
  final String city;
  final String region;
  final String neighborhood;
  final String title;
  final String address;
  final String type;
  final String fclass;
  final List<double> coordinates;

  Location({
    required this.province,
    required this.county,
    required this.district,
    required this.city,
    required this.region,
    required this.neighborhood,
    required this.title,
    required this.address,
    required this.type,
    required this.fclass,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      province: json['province'] ?? '',
      county: json['county'] ?? '',
      district: json['district'] ?? '',
      city: json['city'] ?? '',
      region: json['region'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      type: json['type'] ?? '',
      fclass: json['fclass'] ?? '',
      coordinates: json.containsKey('geom') && json['geom'].containsKey('coordinates')
          ? List<double>.from(json['geom']['coordinates'])
          : [],
    );
  }
}


LatLng parseLocation(String location) {
  final parts = location.split(',');
  if (parts.length == 2) {
    final latitude = double.tryParse(parts[0]);
    final longitude = double.tryParse(parts[1]);
    if (latitude != null && longitude != null) {
      return LatLng(latitude, longitude);
    }
  }
  return LatLng(0.0, 0.0); // Default or error value
}



// صفحه‌ی انتخاب مکان
class AddLocationPage extends StatefulWidget {
  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  LatLng? selectedLocation;
  final TextEditingController _searchController = TextEditingController();
  double _zoom = 15;
  MapController _mapController = MapController();
  List<Location> _searchResults = [];
  final String apiKey = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1In0.eyJhdWQiOiIyODIxMyIsImp0aSI6ImMzNjVkMDg2NjdmMzgxZDY1ZmI2NzU0ODcwNDJmZTQ1M2I1MzgxODEyMWY5YTE2OTIwNjFlNDY2NDA2MmNlYzE0NjZmNzIzZDEzMzk4NTk1IiwiaWF0IjoxNzIxOTQwODg3LCJuYmYiOjE3MjE5NDA4ODcsImV4cCI6MTcyNDUzMjg4Nywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.P-HVICCEemigM5vv_lYuxVogPRp3_Tpa1-6zJWONRJ9BfsWXKd4B6FPgnxmJg1wkSGOXc_GFFoeZuFrf9nRfJzwdofkbFbI9yrtWWMATW2PIY8zjd_2SoZ4O94HE-AfyPOO4Dq_V7TJV1xiGinIJdyFCCfMBAuxN-2p8etP5UF2R6r9gDqxXpeVXiHbDx2zB9nTpONG_rlCi26SJ4Y63rDhsAOppdW6v0bP8bF7wkcOJ_z2lwzaWpcOnvJ0uP0cnYc_y9MiINw_P0g79MWMV-ntFNaaj_LU5G_kvSb9y0uWbmFrPgLoEgRFkdkRK2OEAORd9b5ux_iJGnkYV39UHPQ'; // کلید API خود را وارد کنید

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }



  Future<void> _searchLocation(String query) async {
    final url = Uri.parse('https://map.ir/search/v2/autocomplete');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey, // اطمینان حاصل کنید که apiKey را درست تنظیم کرده‌اید
      },
      body: jsonEncode({
        'text': query,
        // استفاده صحیح از کلید برای فیلتر
        '\$filter': 'city eq تهران' // باید به صورت String باشد و \ را برای جلوگیری از تداخل استفاده کنید
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map && data.containsKey('value')) {
        setState(() {
          _searchResults = (data['value'] as List)
              .map((item) => Location.fromJson(item as Map<String, dynamic>))
              .toList();
        });
      } else {
        print('Unexpected data format');
      }
    } else {
      print('Failed to fetch search results');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  void _moveToLocation(double lat, double lon) {
    final newLocation = LatLng(lat, lon);
    setState(() {
      selectedLocation = newLocation;
      _mapController.move(newLocation, _zoom);
      _searchResults = [];
      _searchController.clear();
    });
  }
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
      _mapController.move(selectedLocation!, _zoom);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('انتخاب مکان'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              minZoom: 9, // مقدار زوم مینیموم
              maxZoom: 18,
              center: selectedLocation ?? LatLng(35.7045368,51.4045376),
              zoom: _zoom,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedLocation = point;
                });
              },
            ),
            children: [
              TileLayer(
                  urlTemplate:
                  "https://map.ir/shiveh/xyz/1_2.0.0/Shiveh:Shiveh@EPSG:3857@png/{z}/{x}/{y}.png"
                      "?x-api-key=${apiKey}"),

              if (selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLocation!,
                      builder: (ctx) => Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'جستجوی مکان',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: _searchLocation,
                ),
                if (_searchResults.isNotEmpty)
                  Container(
                    color: Colors.white,
                    height: 200,
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final result = _searchResults[index];
                        return ListTile(
                          title: Text(result.title),
                          subtitle: Text('${result.address} \nLat: ${result.coordinates[1]}, Lon: ${result.coordinates[0]}'),
                          onTap: () {
                            _moveToLocation(result.coordinates[1], result.coordinates[0]);
                          },
                        );
                      },
                    ),
                  ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _zoom++;
                          _mapController.move(_mapController.center, _zoom);
                        });
                      },
                      child: Icon(Icons.zoom_in),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _zoom--;
                          _mapController.move(_mapController.center, _zoom);
                        });
                      },
                      child: Icon(Icons.zoom_out),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // if (selectedLocation != null)
          //   Positioned(
          //     bottom: 10,
          //     left: 10,
          //     right: 10,
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.of(context).pop(selectedLocation);
          //       },
          //       child: Text('انتخاب مکان'),
          //     ),
          //   ),
          if (selectedLocation != null)
            Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop(selectedLocation);
                },
                child: Icon(Icons.check),
                backgroundColor: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}
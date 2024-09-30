

import 'package:pocketbase/pocketbase.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';



class SupplierController extends GetxController {
  var suppliers = <RecordModel>[].obs;
  final pb = PocketBaseService().client;

  @override
  void onInit() {
    fetchSuppliers();
    super.onInit();
  }

  Future<void> fetchSuppliers() async {
    final resultList = await pb.collection('suppliers').getFullList(sort: '-created');
    suppliers.assignAll(resultList);
    update();
  }

  Future<void> addSupplier(Map<String, dynamic> supplierData) async {
    final location = supplierData['location'] ?? '';
    final (latitude, longitude) = _parseLocation(location);
    supplierData['latitude'] = latitude.toString();
    supplierData['longitude'] = longitude.toString();
    await pb.collection('suppliers').create(body: supplierData);
    fetchSuppliers();
  }

  Future<void> updateSupplier(String id, Map<String, dynamic> supplierData) async {
    final location = supplierData['location'] ?? '';
    final (latitude, longitude) = _parseLocation(location);
    supplierData['latitude'] = latitude.toString();
    supplierData['longitude'] = longitude.toString();
    await pb.collection('suppliers').update(id, body: supplierData);
    fetchSuppliers();
    }


  Future<void> deleteSupplier(String id) async {
    await pb.collection('suppliers').delete(id);
    fetchSuppliers();
  }

  // Helper method to extract latitude and longitude from "lat,long" format
  (String, String) _parseLocation(String location) {
    final parts = location.split(',');
    final latitude = parts.isNotEmpty ? parts[0] : '0';
    final longitude = parts.length > 1 ? parts[1] : '0';
    return (latitude, longitude);
  }
}



class PocketBaseService {
  final PocketBase pb = PocketBase('https://saater.liara.run');

  PocketBase get client => pb;
}



class SupplierApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SupplierPage(),
    );
  }
}



class SupplierPage extends StatelessWidget {
  final SupplierController controller = Get.put(SupplierController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Suppliers')),
      body: Obx(() {

        if (controller.suppliers.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.suppliers.length,
          itemBuilder: (context, index) {
            final supplier = controller.suppliers[index];
            final latitude = double.tryParse(supplier.data['latitude'] ?? '0') ?? 0;
            final longitude = double.tryParse(supplier.data['longitude'] ?? '0') ?? 0;

            return Card(
              child: ListTile(
                title: Text(supplier.data['companyname'] ?? 'No Company Name'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(supplier.data['phonenumber'] ?? 'No Phone Number'),
                    Text(supplier.data['address'] ?? 'No Address'),
                    Container(
                      height: 150,
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(35.7032600, 51.4064239), // Default location for testing
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
                                point: LatLng(35.7032600, 51.4064239), // Default marker for testing
                                builder: (context) => Icon(Icons.location_on, color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )

                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _showSupplierDialog(context, supplier),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => controller.deleteSupplier(supplier.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSupplierDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showSupplierDialog(BuildContext context, RecordModel? supplier) {
    final TextEditingController companyNameController = TextEditingController(text: supplier?.data['companyname']);
    final TextEditingController phoneNumberController = TextEditingController(text: supplier?.data['phonenumber']);
    final TextEditingController addressController = TextEditingController(text: supplier?.data['address']);
    final TextEditingController locationController = TextEditingController(text: supplier?.data['location']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(supplier == null ? 'Add Supplier' : 'Edit Supplier'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: companyNameController, decoration: InputDecoration(labelText: 'Company Name')),
              TextField(controller: phoneNumberController, decoration: InputDecoration(labelText: 'Phone Number')),
              TextField(controller: addressController, decoration: InputDecoration(labelText: 'Address')),
              TextField(controller: locationController, decoration: InputDecoration(labelText: 'Location (lat,long)')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final supplierData = {
                  'companyname': companyNameController.text,
                  'phonenumber': phoneNumberController.text,
                  'address': addressController.text,
                  'location': locationController.text,
                };
                if (supplier == null) {
                  controller.addSupplier(supplierData);
                } else {
                  controller.updateSupplier(supplier.id, supplierData);
                }
                Navigator.pop(context);
              },
              child: Text(supplier == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  void _showAddSupplierDialog(BuildContext context) {
    final TextEditingController companyNameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Supplier'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: companyNameController, decoration: InputDecoration(labelText: 'Company Name')),
              TextField(controller: phoneNumberController, decoration: InputDecoration(labelText: 'Phone Number')),
              TextField(controller: addressController, decoration: InputDecoration(labelText: 'Address')),
              TextField(controller: locationController, decoration: InputDecoration(labelText: 'Location (lat,long)')),
              ElevatedButton(
                onPressed: () async {
                  final selectedLocation = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddLocationPage()),
                  );
                  if (selectedLocation != null) {
                    locationController.text = selectedLocation;
                  }
                },
                child: Text('Select Location'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final supplierData = {
                  'companyname': companyNameController.text,
                  'phonenumber': phoneNumberController.text,
                  'address': addressController.text,
                  'location': locationController.text,
                };
                controller.addSupplier(supplierData);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}


class AddLocationPage extends StatefulWidget {
  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  LatLng? selectedLocation;
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final LocationController locationController = Get.find();
  double _zoom = 13.0;
  final MapController _mapController = MapController();
  List<Map<String, dynamic>> _searchResults = [];

  Future<void> _searchLocation(String query) async {
    final url = 'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _searchResults = data.cast<Map<String, dynamic>>();
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Location'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(32.4279, 53.6880),
              zoom: _zoom,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedLocation = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
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
                    hintText: 'Search Location',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: _searchLocation,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _searchResults = [];
                      });
                    }
                  },
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
                          title: Text(result['display_name']),
                          onTap: () {
                            _moveToLocation(double.parse(result['lat']), double.parse(result['lon']));
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
                      heroTag: 'zoom_in',
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
                      heroTag: 'zoom_out',
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
          if (selectedLocation != null)
            Positioned(
              bottom: 50,
              left: 50,
              child: Column(
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      controller: _labelController,
                      decoration: InputDecoration(
                        labelText: 'Label',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedLocation != null && _labelController.text.isNotEmpty) {
                        final newLocation = Location(
                          position: selectedLocation!,
                          label: _labelController.text,
                        );
                        locationController.addLocation(newLocation);
                        Navigator.pop(context, newLocation);
                      }
                    },
                    child: Text('Add Location'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Define Location class or model if not already defined
class Location {
  final LatLng position;
  final String label;

  Location({required this.position, required this.label});
}

// Define LocationController if not already defined
class LocationController extends GetxController {
  void addLocation(Location location) {
    // Implementation for adding location
    print('Location Added: ${location.position}, ${location.label}');
  }
}

void main() => runApp(SupplierApp());
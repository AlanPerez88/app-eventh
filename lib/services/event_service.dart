import 'dart:convert';
import 'dart:io';

import 'package:eventh/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;



class EventsService extends ChangeNotifier {

  final String _baseUrl = 'app-eventh-default-rtdb.firebaseio.com';
  final List<Event> events = [];
  late Event selectedProduct;

  final storage = const FlutterSecureStorage();

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  EventsService() {
    loadEvents();
  }

  Future<List<Event>> loadEvents() async {

    isLoading = true;
    notifyListeners();
    
    final url = Uri.https( _baseUrl, 'events.json', {
      'auth': await storage.read(key: 'token') ?? ''
    });
    final resp = await http.get( url );

    final Map<String, dynamic> eventsMap = json.decode( resp.body );

    eventsMap.forEach((key, value) {
      final tempEvent = Event.fromMap( value );
      tempEvent.id = key;
      events.add( tempEvent );
    });


   // this.isLoading = false;
    notifyListeners();

    return events;

  }


  // Future saveOrCreateProduct( Product product ) async {

  //   isSaving = true;
  //   notifyListeners();

  //   if ( product.id == null ) {
  //     // Es necesario crear
  //     await this.createProduct( product );
  //   } else {
  //     // Actualizar
  //     await this.updateProduct( product );
  //   }



  //   isSaving = false;
  //   notifyListeners();

  // }
  

  // Future<String> updateProduct( Product product ) async {

  //   final url = Uri.https( _baseUrl, 'products/${ product.id }.json', {
  //     'auth': await storage.read(key: 'token') ?? ''
  //   });

  //   final resp = await http.put( url, body: product.toJson() );
  //   final decodedData = resp.body;

  //   //TODO: Actualizar el listado de productos
  //   final index = this.products.indexWhere((element) => element.id == product.id );
  //   this.products[index] = product;

  //   return product.id!;

  // }

  // Future<String> createProduct( Product product ) async {

  //   final url = Uri.https( _baseUrl, 'products.json',{
  //     'auth': await storage.read(key: 'token') ?? ''
  //   });
    
  //   final resp = await http.post( url, body: product.toJson() );
  //   final decodedData = json.decode( resp.body );

  //   product.id = decodedData['name'];

  //   this.products.add(product);
    

  //   return product.id!;

  // }
  

  // void updateSelectedProductImage( String path ) {

  //   this.selectedProduct.picture = path;
  //   this.newPictureFile = File.fromUri( Uri(path: path) );

  //   notifyListeners();

  // }

  // Future<String?> uploadImage() async {

  //   if (  this.newPictureFile == null ) return null;

  //   this.isSaving = true;
  //   notifyListeners();

  //   final url = Uri.parse('https://api.cloudinary.com/v1_1/dx0pryfzn/image/upload?upload_preset=autwc6pa');

  //   final imageUploadRequest = http.MultipartRequest('POST', url );

  //   final file = await http.MultipartFile.fromPath('file', newPictureFile!.path );

  //   imageUploadRequest.files.add(file);

  //   final streamResponse = await imageUploadRequest.send();
  //   final resp = await http.Response.fromStream(streamResponse);

  //   if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
  //     print('algo salio mal');
  //     print( resp.body );
  //     return null;
  //   }

  //   this.newPictureFile = null;

  //   final decodedData = json.decode( resp.body );
  //   return decodedData['secure_url'];

  // }

}
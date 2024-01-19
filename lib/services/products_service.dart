

import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';

import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-varios-4837e-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;
  
  bool isLoading = true;
  bool isSaving = false;
  
  File? newPictureFile;


  ProductsService(){
    this.loadProducts();
  }
  
  Future loadProducts() async {


    this.isLoading = true;
    notifyListeners();
       
       final url = Uri.https( _baseUrl , 'products.json');
       final resp = await http.get(url);
       final Map< String , dynamic> productsMap = json.decode( resp.body);

      productsMap.forEach((key, value) { 
        final tempProduct = Product.fromMap( value);
        tempProduct.id =key;
        this.products.add(tempProduct);
      });
      

      this.isLoading = false;
      notifyListeners();
      //print( this.products[0].name);
  }

  Future saveOrCreateProduct(Product product) async{
       
       isSaving = true;
       notifyListeners();


       if( product.id == null){
        await createProduct(product);

       }else{

        await updateProduct(product);
       }

       isSaving= false;
       notifyListeners();

  }

  Future<String> updateProduct(Product product)async{

    final url = Uri.https( _baseUrl , 'products/${product.id}.json');
    final resp = await http.put(url , body: product.toRawJson());
    
    
    final decodeDate = resp.body;
   //Actualizar el listado de productos
    final index = this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!; 

  }
   Future<String> createProduct(Product product)async{

    final url = Uri.https( _baseUrl , 'products.json');
    final resp = await http.post(url , body: product.toRawJson());

    final decodeDate = json.decode(resp.body);
   //Actualizar el listado de productos
   product.id = decodeDate['name'];
   products.add(product);
  return product.id!;

  }

  void updateSelectedImage( String path){
    
    selectedProduct.picture = path;
    newPictureFile = File.fromUri( Uri( path: path));
    notifyListeners();
  }



 Future<String?> uploadImage() async{   

    isSaving = true;     
     notifyListeners(); 


      final url = Uri.parse('https://res.cloudinary.com/drkilsint/image/upload?upload_preset=gftltf44'); 
           if(newPictureFile != null){ 
          final imageUploadRequest = http.MultipartRequest('POST', url);        
          final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);   

        imageUploadRequest.files.add(file);  


         final streamResponse = await imageUploadRequest.send();        
         final resp = await http.Response.fromStream(streamResponse);  


          if(resp.statusCode != 200 && resp.statusCode != 201){  


              print('algo salio mal');          
              print(resp.body);  
              return null;         
              }   


              final decodeData =  json.decode(resp.body);    

               newPictureFile =null;          
               
               print(resp.body);  


                return decodeData['secure_url'];     }else{        
                   return null;    
 }  
 } 
 }
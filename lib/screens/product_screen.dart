

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
      

       final productService = Provider.of<ProductsService>(context);

       // return _ProductScreenBody(productService: productService);
       return ChangeNotifierProvider(
        create: ( _) => ProductFormProvider(productService.selectedProduct),
        child: _ProductScreenBody(productService: productService),
        );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

   final productForm = Provider.of<ProductFormProvider>(context); 
   
    return Scaffold(
          body: SingleChildScrollView(
    child: Column(
      children: [
        Stack(
          children: [
            ProductImage( url: productService.selectedProduct.picture,),
             Positioned(
              top: 60,
              left: 20,
              child: IconButton(  
               icon: const Icon( Icons.arrow_back_ios ,size: 40, color: Color.fromARGB(137, 250, 250, 250) , ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ),
             Positioned(
              top: 60,
              right: 20,
              child: IconButton(
               icon: const Icon( Icons.camera_alt_outlined ,size: 40, color: Color.fromARGB(137, 255, 255, 255) , ),
                onPressed: () async {
                    
                     final picker =  ImagePicker();
                     final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.camera,
                       imageQuality: 100
                        );

                        if( pickedFile == null){
                         print('No seleccionò nada');
                        return;
                     }
                        print('Tenemos imagen ${ pickedFile.path}');
                        productService.updateSelectedImage(pickedFile.path);

                },
              )
            )
          ],
        ),
        _ProductForm(),
    
        const SizedBox( height: 100,)
      ],
    ),
          ),
           
           floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
           floatingActionButton: FloatingActionButton(
           onPressed:  productService.isSaving
     ? null
     :
    
     () async {

       if(!productForm.isValidForm()) return;

       final String? imageUrl = await productService.uploadImage();

       if( imageUrl != null) productForm.product.picture = imageUrl;

       await productService.saveOrCreateProduct(productForm.product);
    },
           child: productService.isSaving
           ? CircularProgressIndicator( color: Colors.white,) 
           : Icon(Icons.save)
     ),
        );
  }
}

class _ProductForm extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric( horizontal: 20),
        width: double.infinity,
        //height: 200,
        decoration: _buildBoxDecoration(),
        child:  Form(
          key:productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child:Column(
          children: [

            const SizedBox( height: 10,),

            TextFormField(
              initialValue: product.name,
              onChanged:  (value) => product.name = value,
              validator: (value)  {
                if( value == null || value.length <1) {
                  return 'name is required';
                }
              },
              decoration: InputDecorations.authInputDecoration(
                 hintText: 'Nombre del producto',
                 labelText: 'Nombre'
                 ),
            ),

            const SizedBox( height: 30,),

            TextFormField(
              initialValue: '${product.price}',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              onChanged: (value){
                if( double.tryParse(value) == null){
                  product.price =0;
                }else{
                  product.price = double.parse(value);
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                 hintText: '\$150',
                 labelText: 'Precio:'
                 ),
            ),
            const SizedBox( height: 30,),

            SwitchListTile.adaptive(
              value: product.available, 
              title: const Text('Disponible'),
              onChanged: ( value){
               productForm.updateAvailibity(value);

              }),

              const SizedBox( height: 30,),
            ],
          )
          ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() =>  BoxDecoration(
    color: Colors.white,
    borderRadius:  const BorderRadius.only( bottomRight: Radius.circular(25) , bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 5)
      )
    ]
  );
}
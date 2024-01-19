import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';

class ProductCard extends StatelessWidget {
   
   final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top:  30 , bottom: 50),
        width: double.infinity,
        height:400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage( product.picture),
            _ProductDetails( title: product.name , subTitle: product.id!,),

             Positioned(
              top: 0,
              right: 0,
              child: _PriceTag( price: product.price,)),

              if( !product.available)
                Positioned(
              top: 0,
             left: 0,
              child: _NotAvaliable())
          ],
        ),
      ),
    );
  }

 

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,8),
        blurRadius: 10
      )
    ]
  );
}

class _NotAvaliable extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 100,
       height: 70,
       decoration: const BoxDecoration(
               color: Color.fromARGB(255, 236, 217, 46),
               borderRadius: BorderRadius.only( 
                topLeft: Radius.circular(25) , bottomRight: Radius.circular(25))
       ),
       child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric( horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle( color:  Colors.white , fontSize: 20),
          ),
          ),
       ),
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag({required this.price});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 178, 148, 230),
        borderRadius: BorderRadius.only( topRight: Radius.circular(25) , bottomLeft: Radius.circular(25))
      ),
      child:   FittedBox(
        fit: BoxFit.contain,
        child:Padding(
          padding: const EdgeInsets.symmetric( horizontal: 10),
           child:  Text( '\$$price', style: const TextStyle( color: Colors.white , fontSize: 20))),
      ),
     
    );
  }
}

class _ProductDetails extends StatelessWidget {
     final String title;
     final String subTitle;

  const _ProductDetails({ 
    required this.title, 
    required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric( horizontal: 20 , vertical: 10),
        width: double.infinity,
        height: 70,
        //color: const Color.fromARGB(255, 178, 148, 230),
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Text(
                title,
                style: const TextStyle(fontSize: 19, color: Colors.white , fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
               ),
               Text(
                subTitle,
                style: const TextStyle(fontSize: 15, color: Colors.white ,),
                
               )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() =>  const BoxDecoration(
    color: Color.fromARGB(255, 178, 148, 230),
    borderRadius: BorderRadius.only( bottomLeft: Radius.circular(25) , topRight: Radius.circular(25))
  );
}

class _BackgroundImage extends StatelessWidget {
    
    final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: getImage(url)
      ),
    );
  }
  Widget getImage( String? picture){
           
           if( picture == null) {
             return  const Image(
            image: AssetImage('assets/no-image.png'),
           fit: BoxFit.cover,
          );
           }

          if( picture.startsWith('http')) {
            return FadeInImage(
            image: NetworkImage(url!),
             placeholder: const AssetImage('assets/jar-loading.gif'),
             fit: BoxFit.cover,
             );
          }

             return Image.file(
              File(picture),
              fit :BoxFit.cover
             );

  }
}
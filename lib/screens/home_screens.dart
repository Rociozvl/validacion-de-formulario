import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    if(productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        
       title: const Center(
        child:  Text('AppBar' , style: TextStyle(color: Color.fromARGB(255, 235, 230, 230))))
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ( _ , int index)=> GestureDetector(

          onTap: () => {
            productsService.selectedProduct = productsService.products[index].copy(),
              Navigator.pushNamed(context, 'product'),
          },
          
          
          child: ProductCard( product: productsService.products[index],))
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
              
              productsService.selectedProduct = Product(
                available: true,
                 name: '', 
                 price: 0);
            Navigator.pushNamed(context, 'product');
          } 
          ),
          
    );
  }
}
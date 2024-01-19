import 'package:flutter/material.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/products_service.dart';
import 'package:provider/provider.dart';




void main() => runApp(AppState());

class AppState extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _)=> ProductsService())
      ],
      child: MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'home',
      routes: {
        'login'   : ( _) => const LoginScreen(),
        'home'    : ( _)=> const HomeScreen(),
        'product' : ( _) => ProductScreen()
      }, 
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color:  Color.fromARGB(255, 178, 148, 230)
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor:  Color.fromARGB(255, 178, 148, 230)
      )
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  
    final Widget child;

  const AuthBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: double.infinity,
      height: double.infinity,
      child:  Stack(
           children: [
               PurpleBox(),

               _HeaderIcon(),

               this.child,
           ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
       margin: const EdgeInsets.only( top: 30),
       width: double.infinity,
       child: const Icon(Icons.person_pin , color: Colors.white , size: 100),
      ),
    );
  }
}
class PurpleBox extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
    
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
            children: [
                Positioned( top:10  , left:-0,child: _Bubble(),),
                Positioned( top:90  , left:90,child: _Bubble(),),
                Positioned( bottom:90  , left:300,child: _Bubble(),),
                Positioned( bottom:-50  , left:50,child: _Bubble(),),
                //Positioned( top:20  , left:30,child: _Bubble(),),
            ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(

    gradient: LinearGradient(
      colors: [
               Color.fromRGBO(63, 63, 156, 1),
               Color.fromRGBO(90, 70, 178, 1)
      ]
      )
  );
}

class _Bubble extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromRGBO(255, 255, 255, 0.05)
          ),
    );
  }
}
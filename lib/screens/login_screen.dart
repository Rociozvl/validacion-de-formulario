import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox( height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox( height: 10,),
                    Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                       ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: _LoginForm(),
                        ),
                    
                  ],
                ),
                ),

               const SizedBox(height: 50,),
               const Text('Crear una nueva cuenta' , style: TextStyle( fontWeight: FontWeight.bold),),
               const SizedBox(height: 50,),
            ],
          ),
        )
        ),
        );
      
    
  }
}
class _LoginForm extends StatelessWidget {
 
    
  @override
  Widget build(BuildContext context) {

  final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
         key: loginForm.formKey,
         autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
                    
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'john.oe@gmailcom', 
                        labelText: 'Email address',
                        prefixIcon: Icons.alternate_email),
                        onChanged: (value )=> loginForm.email = value,
                        validator: (value){
                          String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp  =  RegExp(pattern);

                          return regExp.hasMatch( value ?? '')
                          ? null
                          : 'Correo incorrecto';
                        },
                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecoration(
                        hintText: '******', 
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline
                        ),
                        onChanged: (value )=> loginForm.password = value,
                         validator: (value){
                           return ( value != null && value.length >= 6) 
                            ? null
                          : 'La contraseña debe contener al menos 6 caracteres';
                        },
                        
                    ),
                    const SizedBox( height: 30,),

                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      color: const Color.fromRGBO(103, 58, 183, 1),
                      onPressed: loginForm.isLoading ? null : () async{
                       if( !loginForm.isValidForm()) return;
                       loginForm.isLoading = true;

                       await Future.delayed(const Duration(seconds: 2));

                       Navigator.pushReplacementNamed(context, 'home');
                      },
                      child: Container(
                        padding:  const EdgeInsets.symmetric( horizontal: 50 , vertical: 15),
                        child:  Text(
                          loginForm.isLoading
                          ? 'Espere unos momentos..'
                          :'Log in',
                          
                          
                          
                        style: const TextStyle( color: Colors.white),
                        ),
                      ))
          ],
        ),
    ),
    );
  }
}
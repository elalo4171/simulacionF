import 'package:flutter/material.dart';
import 'package:simulacion/src/pages/generador_adictivo.dart';
import 'package:simulacion/src/pages/generadpr_multiplicativo.dart';
import 'package:simulacion/src/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/pages/show_numeros.dart';
import 'package:simulacion/src/providers/generador_provider.dart';
import 'package:simulacion/src/theme/tema.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider (
          create: (context) => GeneradorAleatorios(),
        )
      ],
        child: MaterialApp(
        title: 'Material App',
        routes: {
          'home':(BuildContext context)=>HomePage(),
          'ver':(BuildContext context)=>ShowNumeros(),
          'adictivo':(BuildContext context)=>Adictivo(),
          'multiplicativo':(BuildContext context)=>Multiplicativo(),
        },
        initialRoute: 'multiplicativo',
        theme: miTema,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
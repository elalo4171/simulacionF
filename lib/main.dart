import 'package:flutter/material.dart';
import 'package:simulacion/src/pages/generador_adictivo.dart';
import 'package:simulacion/src/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/providers/generacion_provider.dart';
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
          'adictivo':(BuildContext context)=>Adictivo()
        },
        initialRoute: 'adictivo',
        theme: miTema,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
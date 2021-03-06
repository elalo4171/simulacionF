import 'package:flutter/material.dart';
import 'package:simulacion/src/pages/generador_adictivo.dart';
import 'package:simulacion/src/pages/generador_mixto.dart';
import 'package:simulacion/src/pages/generadpr_multiplicativo.dart';
import 'package:simulacion/src/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/pages/prueba_corridas.dart' as a;
import 'package:simulacion/src/pages/show_numeros.dart' as b;
import 'package:simulacion/src/providers/generador_provider.dart';
import 'package:simulacion/src/theme/tema.dart';
import 'package:simulacion/src/pages/kolmogorov_page.dart';
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
          'ver':(BuildContext context)=>b.ShowNumeros(storage: b.CounterStorage()),
          'adictivo':(BuildContext context)=>Adictivo(),
          'multiplicativo':(BuildContext context)=>Multiplicativo(),
          'mixto': (BuildContext context) => Mixto(),
          'kolmo':(BuildContext context)=>KolmogorovPage(),
          'corridas':(BuildContext context)=>a.CorridasArribaAbajo(storage: a.CounterStorage(),),
        },
        initialRoute: 'home',
        theme: miTema,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/providers/generador_provider.dart';
import 'package:simulacion/src/utility/responsive.dart';
import 'package:simulacion/src/widgets/tittle_widget.dart';

class CorridasArribaAbajo extends StatefulWidget {
  
  final CounterStorage storage;
  CorridasArribaAbajo({Key key, @required this.storage}) : super(key: key);

  @override
  _CorridasArribaAbajoState createState() => _CorridasArribaAbajoState();
}

class _CorridasArribaAbajoState extends State<CorridasArribaAbajo> {



    List<int> numerosArchivo=[];
    List<double> numerosAcrhivoDouble=[];
    List<double> numerosSeleccionados=[];
  
  @override
  void initState() {
    traerNumeros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    // traerNumeros()
    final generador = Provider.of<GeneradorAleatorios>(context);
    return Scaffold(
       body: SafeArea(
         child: 
         Stack(
           children: <Widget>[
             ListView(
               children: <Widget>[
                Column(
                  children: <Widget>[
                     Container(
                  height: _responsive.height * .1,
                  padding: EdgeInsets.only(
                      top: _responsive.height * .02,
                      left: _responsive.width * .02),
                  child: title("Corridas arriba y abajo","Prueba de alateoridad",TextStyle(fontSize: _responsive.ip * .035), _responsive),
                ),
                Container(
                  child: ListTile(
                    title: Text("Selecciona los numeros a usar"),
                    subtitle: DropdownButton(
                    items: opciones(generador),
                    onChanged: (value) {
                      numerosSeleccionados=value;
                      setState(() {
                      });
                    },
                  ),
                  )
                ),
                numerosSeleccionados.length!=0?
                ListTile(
                  title: Text("Resultados de la prueba"),
                  subtitle: Text(generador.corridasArribaAbajo(numerosSeleccionados)?"No se rechaza que son independientes. ":"No Pasa la prueba de corridas"),
                ):Container(),
                numerosSeleccionados.length!=0?
                Container(
                      width: _responsive.width * .5,
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "Ir a Kolmogorov",
                          style: TextStyle(color: Colors.black),
                        ),
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          generador.numerosKolmogorov=numerosSeleccionados;
                          Navigator.pushNamed(context, 'kolmo');
                        },
                      ),
                    ):Container(),
                  ],
                )
               ],
             )
           ],
         )),
    );
  }

  void traerNumeros() async{
    numerosArchivo = await widget.storage.readCounter();
    print(numerosArchivo);
    for (int i = 0; i < numerosArchivo.length; i ++){
        numerosAcrhivoDouble.add(numerosArchivo[i].toDouble());
      }
      setState(() {

      });
  }

  List<DropdownMenuItem> opciones(GeneradorAleatorios generadorAleatorios){
    List<DropdownMenuItem<List<double>>> items=[];
    if(generadorAleatorios.numerosAleatoriosAdictivo.length!=0){
      items.add(DropdownMenuItem(child: Text("Aleatorios adictivos(Generados)"),value: generadorAleatorios.numerosAleatoriosAdictivo,));
    }
    if(generadorAleatorios.numerosAleatoriosMultiplicativo.length!=0){
      items.add(DropdownMenuItem(child: Text("Aleatorios Multiplicativo(Generados)"),value: generadorAleatorios.numerosAleatoriosMultiplicativo,));
    }
    if(generadorAleatorios.numerosAleatoriosMixto.length!=0){
      items.add(DropdownMenuItem(child: Text("Aleatorios Mixto(Generados)"),value: generadorAleatorios.numerosAleatoriosMixto,));
    }
    if(numerosArchivo.length!=0){
      items.add(DropdownMenuItem(child: Text("Numeros en archivo"),value: numerosAcrhivoDouble,));
    }
    //Archivos



    return items;
  }
  
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    
    return directory.path;
  }


}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<List<int>> readCounter() async {
    try {
      final file = await _localFile;

      // Leer archivo
      List<int> contents = await file.readAsBytes();
      // print(contents);
      return contents;
    } catch (e) {
      // Si encuentras un error, regresamos 0
      return null;
    }
  }

  Future<File> writeCounter(List<int> counter) async {
    final file = await _localFile;

    // Escribir archivo
    return file.writeAsBytes(counter);
  }
}

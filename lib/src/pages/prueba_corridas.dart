import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/providers/generador_provider.dart';
import 'package:simulacion/src/utility/responsive.dart';
import 'package:simulacion/src/widgets/tittle_widget.dart';

class CorridasArribaAbajo extends StatefulWidget {
  CorridasArribaAbajo({Key key}) : super(key: key);

  @override
  _CorridasArribaAbajoState createState() => _CorridasArribaAbajoState();
}

class _CorridasArribaAbajoState extends State<CorridasArribaAbajo> {
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    List<double> numerosSeleccionados=[];
    final generador = Provider.of<GeneradorAleatorios>(context);
    return Scaffold(
       body: SafeArea(
         child: 
         Stack(
           children: <Widget>[
             ListView(
               children: <Widget>[
                 Container(
                  height: _responsive.height * .1,
                  padding: EdgeInsets.only(
                      top: _responsive.height * .02,
                      left: _responsive.width * .02),
                  child: title("Corridas arriba y abajo","Prueba de alateoridad",TextStyle(fontSize: _responsive.ip * .035), _responsive),
                ),
                Container(
                  child: DropdownButton(
                    items: opciones(generador),
                    onChanged: (value) {
                      numerosSeleccionados=value;
                    },
                  ),
                )
               ],
             )
           ],
         )),
    );
  }

  List<DropdownMenuItem> opciones(GeneradorAleatorios generadorAleatorios){
    List<DropdownMenuItem<List<double>>> items=[];
    if(generadorAleatorios.numerosAleatoriosAdictivo.length!=0){
      items.add(DropdownMenuItem(child: Text("Aleatorios adictivos(Generados)"),value: generadorAleatorios.numerosAleatoriosAdictivo,));
    }
    if(generadorAleatorios.numerosAleatoriosMultiplicativo.length!=0){
      items.add(DropdownMenuItem(child: Text("Aleatorios Multiplicativo(Generados)"),value: generadorAleatorios.numerosAleatoriosMultiplicativo,));
    }
    //Archivos



    return items;
  }

}
import 'package:flutter/material.dart';
import 'package:simulacion/src/providers/generacion_provider.dart';
import 'package:simulacion/src/widgets/tittle_widget.dart';

class ShowNumeros extends StatefulWidget {
  const ShowNumeros({Key key}) : super(key: key);

  @override
  _ShowNumerosState createState() => _ShowNumerosState();
}

class _ShowNumerosState extends State<ShowNumeros> {

  String _metodo;
  List<double> _numerosGenerados;

  @override
  void initState() { 
    _numerosGenerados=[];
    _metodo="";
    super.initState();
    
  }

  queMetodo(GeneradorAleatorios info){
    switch (info.metodoSeleccionado) {
      case 1: 
        _metodo="Metodo adictivo";
        _numerosGenerados=info.numerosAleatoriosAdictivo;
        setState(() {});
        break;
      default:
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              tittle("Numeros Generados", _metodo)
            ],
          )
        ],
      ),
    );
  }
}
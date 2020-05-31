import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/providers/generador_provider.dart';
import 'package:simulacion/src/widgets/tittle_widget.dart';
import 'package:simulacion/src/utility/responsive.dart';

class ShowNumeros extends StatefulWidget {
  const ShowNumeros({Key key}) : super(key: key);

  @override
  _ShowNumerosState createState() => _ShowNumerosState();
}

class _ShowNumerosState extends State<ShowNumeros> {
  String _metodo;
  List<double> _numerosGenerados;
  String _periodo;
  @override
  void initState() {
    _numerosGenerados = [];
    _metodo = "";
    _periodo = "";
    super.initState();
  }

  queMetodo(GeneradorAleatorios info) {
    switch (info.metodoSeleccionado) {
      case 1:
        _metodo = "Metodo adictivo";
        _numerosGenerados = info.numerosAleatoriosAdictivo;
        _periodo = info.repeticion(info.numerosAleatoriosAdictivo).toString();
        setState(() {});
        break;
        case 2:
        _metodo= "Metodo multiplicativo";
        _numerosGenerados= info.numerosAleatoriosMultiplicativo;
        _periodo= info.repeticion(info.numerosAleatoriosMultiplicativo).toString();
        break;
        case 3:
        _metodo = "Metodo Mixto";
        _numerosGenerados = info.numerosAleatoriosMixto;
        _periodo = info.repeticion(info.numerosAleatoriosMixto).toString();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final _generador = Provider.of<GeneradorAleatorios>(context);
    Responsive _responsive = new Responsive(context);
    queMetodo(_generador);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: _responsive.width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _responsive.height * .02,
                  ),
                  title("Numeros Generados", _metodo,
                      TextStyle(fontSize: _responsive.ip * .035), _responsive),
                  ListTile(
                    title: Text("Periodo de repeticion"),
                    subtitle: Text(_periodo),
                  ),
                  Center(
                    child: Text("Numeros:"),
                  ),
                  Center(
                      child: Container(
                          width: _responsive.width,
                          height: _responsive.height * .6,
                          child: ListView.builder(
                            itemCount: _numerosGenerados.length,
                            itemBuilder: (context, index) {
                              return Center(
                                  child: Text(
                                      _numerosGenerados[index].toString()));
                            },
                          ))),
                  SizedBox(
                    height: _responsive.height * .02,
                  ),
                  Container(
                    width: _responsive.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Guardar Numeros", style: TextStyle(color: Colors.black),),
                          color: Colors.white,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        RaisedButton(
                          child: Text("Generar otros numeros", style: TextStyle(color: Colors.black),),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

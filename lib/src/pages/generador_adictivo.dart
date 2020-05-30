import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/providers/generacion_provider.dart';
import 'package:simulacion/src/utility/responsive.dart';

class Adictivo extends StatefulWidget {
  Adictivo({Key key}) : super(key: key);

  @override
  _AdictivoState createState() => _AdictivoState();
}

class _AdictivoState extends State<Adictivo> {
  TextEditingController _controllerSemillas;
  TextEditingController _controllerModulo;
  TextEditingController _controllerCantidad;
  List<double> _semillas;
  int _modulo;
  int _cantidad_semillas;
  bool _editModulo;
  bool _editCantidad;
  @override
  void initState() {
    _editModulo = true;
    _editCantidad = true;
    _controllerSemillas = new TextEditingController();
    _controllerModulo = new TextEditingController();
    _controllerCantidad = new TextEditingController();
    _semillas = [];
    _modulo = 100;
    _cantidad_semillas = 100;
    super.initState();
  }

  String generarSemillasTexto(List semillas) {
    String texto = "";
    for (var item in semillas) {
      texto = texto + " , " + item.toString();
    }
    return texto;
  }

  @override
  Widget build(BuildContext context) {
    final generador = Provider.of<GeneradorAleatorios>(context);
    Responsive _responsive = new Responsive(context);
    TextStyle tittle =
        TextStyle(fontSize: _responsive.ip * .035, fontWeight: FontWeight.w900);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  height: _responsive.height * .1,
                  padding: EdgeInsets.only(
                      top: _responsive.height * .02,
                      left: _responsive.width * .02),
                  child: tiitlePage(tittle, _responsive),
                ),
                Container(
                  height: _responsive.height * .87,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: _responsive.height * .03,
                      ),
                      ingresarSemillas(),
                      SizedBox(
                        height: _responsive.height * .015,
                      ),
                      _semillas.length != 0 ? showSemillas() : Container(),
                      _semillas.length != 0
                          ? SizedBox(
                              height: _responsive.height * .015,
                            )
                          : Container(),
                      ingresarModulo(),
                      SizedBox(
                        height: _responsive.height * .015,
                      ),
                      ingresarCantidad(),
                      SizedBox(
                        height: _responsive.height * .015,
                      ),
                      RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "Generar",
                          style: TextStyle(color: Colors.black),
                        ),
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          generador.numerosAleatoriosAdictivo =
                              generador.generarAdictivo(
                                  _semillas, _modulo, _cantidad_semillas);
                          generador.metodoSeleccionado = 1;
                          _semillas = [];
                          _modulo = 0;
                          _cantidad_semillas = 0;
                          _controllerCantidad.clear();
                          _controllerModulo.clear();
                          _controllerSemillas.clear();
                          _editCantidad = true;
                          _editModulo = true;
                          Navigator.pushNamed(context, 'ver');
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListTile tiitlePage(TextStyle tittle, Responsive _responsive) {
    return ListTile(
      title: Text(
        'Generador adictivo',
        style: tittle,
      ),
      subtitle: Container(
          padding: EdgeInsets.only(left: _responsive.width * .02),
          child: Text("Metodo congruencial")),
    );
  }

  ListTile ingresarModulo() {
    return ListTile(
      title: Text("Ingresa el modulo  ( Multiplo de 2 recomendado )"),
      subtitle: TextField(
        enabled: _editModulo,
        controller: _controllerModulo,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
      trailing: IconButton(
          icon: Icon(
            _editModulo ? Icons.add : Icons.edit,
            color: Colors.white,
          ),
          onPressed: _editModulo
              ? () {
                  _modulo = int.parse(_controllerModulo.value.text);
                  _editModulo = false;
                  setState(() {});
                }
              : () {
                  _editModulo = true;
                  setState(() {});
                }),
    );
  }

  ListTile showSemillas() {
    return ListTile(
      title: Text("Semillas ingresadas"),
      subtitle: Text(generarSemillasTexto(_semillas)),
      trailing: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            _semillas = [];
            setState(() {});
          }),
    );
  }

  ListTile ingresarSemillas() {
    return ListTile(
      title: Text("Ingrese las semillas"),
      subtitle: TextField(
        controller: _controllerSemillas,
        keyboardType: TextInputType.number,
      ),
      trailing: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _semillas.add(double.parse(_controllerSemillas.value.text));
            _controllerSemillas.clear();
            setState(() {});
          }),
    );
  }

  ListTile ingresarCantidad() {
    return ListTile(
      title: Text("Ingresa la cantidad de semillas a generar"),
      subtitle: TextField(
        controller: _controllerCantidad,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
      trailing: IconButton(
          icon: Icon(_editCantidad ? Icons.add : Icons.edit),
          onPressed: _editCantidad
              ? () {
                  _cantidad_semillas =
                      int.parse(_controllerCantidad.value.text);
                  _editCantidad = false;
                  setState(() {});
                }
              : () {
                  _editCantidad = true;
                  setState(() {});
                }),
    );
  }
}

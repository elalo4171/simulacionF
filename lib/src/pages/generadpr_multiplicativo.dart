import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/providers/generador_provider.dart';
import 'package:simulacion/src/utility/responsive.dart';
import 'package:simulacion/src/widgets/tittle_widget.dart';

class Multiplicativo extends StatefulWidget {
  Multiplicativo({Key key}) : super(key: key);

  @override
  _MultiplicativoState createState() => _MultiplicativoState();
}

class _MultiplicativoState extends State<Multiplicativo> {
  TextEditingController _controllerCantidad;
  TextEditingController _controllerModulo;
  TextEditingController _controllerSemilla;
  TextEditingController _controllerMultiplicativa;
  int _cantidad_semillas;
  int _modulo;
  double _semilla;
  int _multiplicativa;

  @override
  void initState() {
    _controllerModulo = new TextEditingController();
    _controllerCantidad = new TextEditingController();
    _controllerSemilla = new TextEditingController();
    _semilla = 0;
    _cantidad_semillas = 0;
    _modulo = 0;
    _multiplicativa=0;
    
    // TODO: implement initState
    super.initState();
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
                      // ingresarSemillas(),
                      ingresarModulo(),
                      SizedBox(
                        height: _responsive.height * .015,
                      ),
                      ingresarSemilla(),
                      SizedBox(
                        height: _responsive.height * .015,
                      ),
                      ingresarMultiplicativo(),

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
                          generador.numerosAleatoriosMultiplicativo =
                              generador.generadorMultiplicativo(
                                  _semilla,_multiplicativa,  _modulo, _cantidad_semillas);
                          generador.metodoSeleccionado = 2;
                          _semilla = 0;
                          _modulo = 0;
                          _cantidad_semillas = 0;
                          _controllerCantidad.clear();
                          _controllerModulo.clear();
                          _controllerSemilla.clear();
                          Navigator.pushNamed(context, 'ver');
                        },
                      ),
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
        'Generador multiplicativo',
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
        controller: _controllerModulo,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        onChanged: (val) {
          _modulo = int.parse(val);
          setState(() {});
        },
      ),
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
        onChanged: (val) {
          _cantidad_semillas = int.parse(val);
          setState(() {});

        },
      ),
    );
  }

  Widget ingresarSemilla() {
    return ListTile(
      title: Text("Ingresa la semilla"),
      subtitle: TextField(
        controller: _controllerSemilla,
        keyboardType: TextInputType.number,
        onChanged: (val) {
          _semilla = double.parse(val);
          setState(() {});

        },
      ),
    );
  }

  ListTile ingresarMultiplicativo() {
    return ListTile(
      title: Text("Ingresa la variable multiplicativa"),
      subtitle: TextField(
        controller: _controllerMultiplicativa,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        onChanged: (val){
          _multiplicativa= int.parse(val);
          setState(() {});
        },
      ),
    );
  }
}

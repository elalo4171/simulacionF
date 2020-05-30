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
  List<double> _semillas;
  int _modulo;
  int _numero_semilla;

  @override
  void initState() {
    // TODO: implement initState
    _controllerSemillas = new TextEditingController();
    _semillas = [];
    _modulo = 100;
    _numero_semilla = 100;
    super.initState();
  }

  String generarSemillasTexto(List semillas){
    String texto="";
    for (var item in semillas) {
      texto=texto+" , "+item.toString();
    }
    return texto;
  }

  @override
  Widget build(BuildContext context) {
    final adictivo = Provider.of<GeneradorAleatorios>(context);
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
                  child: ListTile(
                    title: Text(
                      'Generador adictivo',
                      style: tittle,
                    ),
                    subtitle: Container(
                        padding: EdgeInsets.only(left: _responsive.width * .02),
                        child: Text("Metodo congruencial")),
                  ),
                ),
                Container(
                  height: _responsive.height * .87,
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      ingresarSemillas(),
                      SizedBox(
                        height: _responsive.height * .03,
                      ),
                      showSemillas()
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

  ListTile showSemillas() {
    return ListTile(
                      title: Text("Semillas ingresadas"),
                      subtitle: Text(generarSemillasTexto(_semillas)),
                      trailing: IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: null),
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
            setState(() {
              
            });
          }),
    );
  }
}

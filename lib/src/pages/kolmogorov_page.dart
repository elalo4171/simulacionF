import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/providers/generador_provider.dart';
import 'package:simulacion/src/widgets/tittle_widget.dart';
import 'package:simulacion/src/utility/responsive.dart';

class KolmogorovPage extends StatefulWidget {
  KolmogorovPage({Key key}) : super(key: key);

  @override
  _KolmogorovPageState createState() => _KolmogorovPageState();
}

class _KolmogorovPageState extends State<KolmogorovPage> {
  GeneradorAleatorios _generadorAleatorios;
  String _resul = "";
  bool _resulBool = false;
  @override
  void initState() {
    super.initState();
  }

  getData(GeneradorAleatorios _generador) {
    _resulBool = _generador.getKolmogorov();
    if (_resulBool) {
      _resul = "Prueba de Kolmogorov: Se acepta la hipotesis de que los numeros tienen una distribucion uniforme";
    } else {
      _resul = "Prueba de Kolmogorov: Se rechaza la hipotesis de que los numeros tienen una distribucion uniforme \n Se tiene que hacer la prueba de aceptacion y rechazo";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _generadorAleatorios = Provider.of<GeneradorAleatorios>(context);
    Responsive _responsive = new Responsive(context);
    TextStyle _title = new TextStyle(fontSize: _responsive.ip * .035);
    // getData(_generadorAleatorios);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: _responsive.height * .02),
                        child: title("Kolmogorov smirnov", "Prueba de bondad",
                            _title, _responsive)),
                    Divider(),
                    ListTile(
                      title: Text("Resultado de los numeros seleccionados"),
                      subtitle: Text(_resul),
                    ),
                    !_resulBool?Container(
                      width: _responsive.width * .5,
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "Ir a aceptacion y rechazo",
                          style: TextStyle(color: Colors.black),
                        ),
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(context, 'ver');
                        },
                      ),
                    ):Container(),
                    _resulBool?Container(
                      width: _responsive.width * .5,
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "Ir a MonteCarlo",
                          style: TextStyle(color: Colors.black),
                        ),
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(context, 'ver');
                        },
                      ),
                    ):Container(),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

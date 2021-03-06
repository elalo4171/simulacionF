import 'package:flutter/material.dart';
import 'package:simulacion/src/utility/responsive.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: _responsive.height * .03, horizontal: _responsive.width*.02),
                child: Text("Simulacion", style: TextStyle(fontSize: _responsive.ip*.033, fontWeight: FontWeight.w600),),
              ),
              Divider(),
              SizedBox(
                height: _responsive.height * .02,
              ),
              subtitle("Metodos de generacion de numeros pseudoaleatorios",
                  _responsive),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: _responsive.height * .03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    cardCustom(
                        "Multiplicativo",
                        "ESTE ES EL CONTENIDO",
                        'multiplicativo',
                        Colors.cyan,
                        _responsive,
                        context,
                        _responsive.width * .3),
                    cardCustom(
                        "Adictivo",
                        "ESTE ES EL CONTENIDO",
                        'adictivo',
                        Colors.cyan,
                        _responsive,
                        context,
                        _responsive.width * .3),
                    cardCustom(
                        "Mixto",
                        "ESTE ES EL CONTENIDO",
                        'mixto',
                        Colors.cyan,
                        _responsive,
                        context,
                        _responsive.width * .3),
                  ],
                ),
              ),
              SizedBox(
                height: _responsive.height * .02,
              ),
              subtitle("Verificar numeros", _responsive),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: _responsive.height * .03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    cardCustom(
                        "Bondad y ajuste",
                        "ESTE ES EL CONTENIDO",
                        'corridas',
                        Colors.cyan,
                        _responsive,
                        context,
                        _responsive.width * .7),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container subtitle(String subtitle, Responsive _responsive) {
    return Container(
      padding: EdgeInsets.only(left: _responsive.width * .03),
      child: Text(
        subtitle,
        style: TextStyle(
            fontSize: _responsive.ip * .025, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }

  Widget cardCustom(String title, String content, String route, Color color,
      Responsive _responsive, BuildContext context, double width) {
    return Container(
      height: _responsive.height * .1,
      width: width,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: _responsive.ip * .02, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

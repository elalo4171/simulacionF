import 'package:flutter/material.dart';
import 'package:simulacion/src/utility/responsive.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Simulacion"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(height: _responsive.height*.02,),
              Container(
                padding: EdgeInsets.only(left: _responsive.width*.03),
                child: Text("Metodos de generacion de numeros pseudoaleatorios", 
                style: TextStyle(fontSize: _responsive.ip*.025,fontWeight: FontWeight.w500),),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: _responsive.height*.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    cardCustom("Multiplicativo", "ESTE ES EL CONTENIDO", 'paas', Colors.cyan, _responsive),
                    cardCustom("Adictivo", "ESTE ES EL CONTENIDO", 'paas', Colors.cyan, _responsive),
                    cardCustom("Mixto", "ESTE ES EL CONTENIDO", 'paas', Colors.cyan, _responsive),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cardCustom(String title, String content, String route, Color color,
      Responsive _responsive) {
    return Container(
      height: _responsive.height * .1,
      width: _responsive.width*.3,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(title, style: TextStyle(fontSize: _responsive.ip*.02),)],
        ),
      ),
    );
  }
}

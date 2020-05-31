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
              Container(
                padding: EdgeInsets.symmetric(vertical: _responsive.height*.03),
                child: Column(
                  children: <Widget>[
                    cardCustom("HOla", "ESTE ES EL CONTENIDO", 'paas',
                        Colors.orange, _responsive)
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
      height: _responsive.height * .2,
      width: _responsive.width*.3,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[Text(title)],
        ),
      ),
    );
  }
}

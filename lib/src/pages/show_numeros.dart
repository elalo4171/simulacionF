import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:simulacion/src/providers/generador_provider.dart';
import 'package:simulacion/src/widgets/tittle_widget.dart';
import 'package:simulacion/src/utility/responsive.dart';

class ShowNumeros extends StatefulWidget {
  final CounterStorage storage;
  const ShowNumeros({Key key, @required this.storage}) : super(key: key);

  @override
  _ShowNumerosState createState() => _ShowNumerosState();
}

class _ShowNumerosState extends State<ShowNumeros> {
  String _metodo;
  List<double> _numerosGenerados;
  List<int> _numerosArchivos;
  String _periodo;
  dynamic _directory;
  @override
  void initState() {
    _numerosGenerados = [];
    _metodo = "";
    _periodo = "";
    _localPath;
    super.initState();
    widget.storage.readCounter().then((List<int> value) {
      setState(() {
        _numerosArchivos = value;
      });
    });
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
      body: Builder(
              builder: (context) => SafeArea(
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
                            onPressed: () {escribirArchivo(context);},
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
      ),
    );
  }
  escribirArchivo(contexts)async {
    List<int> temp = [];
    for (var i = 0; i < _numerosGenerados.length; i++)
      temp.add(_numerosGenerados[i].toInt());
    widget.storage.writeCounter(temp);
    final snackBar = SnackBar(
      content: Text(await _localPath, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(contexts).showSnackBar(snackBar);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    
    return directory.path;
  }


}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<List<int>> readCounter() async {
    try {
      final file = await _localFile;

      // Leer archivo
      List<int> contents = await file.readAsBytes();

      return contents;
    } catch (e) {
      // Si encuentras un error, regresamos 0
      return null;
    }
  }

  Future<File> writeCounter(List<int> counter) async {
    final file = await _localFile;

    // Escribir archivo
    return file.writeAsBytes(counter);
  }
}

import 'package:flutter/material.dart';

class GeneradorAleatorios with ChangeNotifier {
// ----------------------------------------------------------------------------------------------------------
  int _metodoSeleccionado = 0;

  set metodoSeleccionado(int numero) {
    _metodoSeleccionado = numero;
    notifyListeners();
  }

  int get metodoSeleccionado => _metodoSeleccionado;

// ----------------------------------------------------------------------------------------------------------

  List<double> _aleatoriosAdictivo = [];

  get numerosAleatoriosAdictivo => _aleatoriosAdictivo;

  set numerosAleatoriosAdictivo(List numeros) {
    _aleatoriosAdictivo = numeros;
    notifyListeners();
  }

// ----------------------------------------------------------------------------------------------------------
//Metodo para generar numero pseudoaleatorios por el metodo adictivo

  generarAdictivo(List<double> semillas, int modulo, int numero_semillas) {
    if (semillas.length <= 2) {
      print(semillas.length);
      print("Problemas con las semillas");
      return -1;
    }
    if (modulo % 2 != 0) {
      print("Problema con el modulo");
      return -1;
    }
    List<double> semillasTemporales = [];
    semillasTemporales = semillas;
    for (var i = 0; i < numero_semillas; i++) {
      double suma = semillasTemporales[i] +
          semillasTemporales[semillasTemporales.length - 1];
      double conModulo = suma % 100;
      semillasTemporales.add(conModulo);
    }
    return semillasTemporales;
  }

// ----------------------------------------------------------------------------------------------------------

//Metodo para saber la repeticion de numeros generados

  int repeticion(List numeros) {
    int veces = 0;
    for (var i = 0; i < numeros.length; i++) {
      for (var j = 0; j < numeros.length; j++) {
        if (numeros[i] == numeros[j]) {
          veces++;
        }
      if (veces==2) 
      return j;
      }
    }
    return 0;
  }
}

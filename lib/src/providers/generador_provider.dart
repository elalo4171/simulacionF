import 'dart:math';

import 'package:flutter/material.dart';
import "package:normal/normal.dart";
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

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
// ----------------------------------------------------------------------------------------------------------

  List<double> _aleatoriosMultiplicativo = [];

  get numerosAleatoriosMultiplicativo => _aleatoriosMultiplicativo;

  set numerosAleatoriosMultiplicativo(List<double> numeros) {
    _aleatoriosMultiplicativo = numeros;
    notifyListeners();
  }

// ----------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------

  List<double> _aleatoriosMixto = [];

  get numerosAleatoriosMixto => _aleatoriosMixto;

  set numerosAleatoriosMixto(List<double> numeros) {
    _aleatoriosMixto = numeros;
    notifyListeners();
  }

// ----------------------------------------------------------------------------------------------------------
//Metodo para generar numero pseudoaleatorios por el metodo adictivo

  generarAdictivo(List<double> semillas, int modulo, int numeroSemillas) {
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
    for (var i = 0; i < numeroSemillas; i++) {
      double suma = semillasTemporales[i] +
          semillasTemporales[semillasTemporales.length - 1];
      double conModulo = suma % modulo;
      semillasTemporales.add(conModulo);
    }
    return semillasTemporales;
  }

// ----------------------------------------------------------------------------------------------------------
//Metodo para la generacion de numeros por el metodo congruencial multiplicativo
  generadorMultiplicativo(
      double semilla, int multiplicador, int modulo, int numeroSemillas) {
    if (multiplicador % 3 == 0 ||
        multiplicador % 5 == 0 ||
        multiplicador % 2 == 0) {
      print("Error con el multiplicador");
      return -1;
    }
    if (semilla < 0) {
      print("Error en semilla");
      return -1;
    }
    if (modulo % 2 != 0) {
      print("Problema con el modulo");
      return -1;
    }
    List<double> semillas = [];
    semillas.add(semilla);
    for (var i = 0; i < numeroSemillas; i++) {
      semillas.add((semillas[semillas.length - 1] * multiplicador) % 100);
    }
    return semillas;
  }

// ----------------------------------------------------------------------------------------------------------
//Metodo para la generacion de numeros por el metodo congruencial mixto
  generadorMixto(double semilla, int multiplicador, int modulo, int constante,
      int numeroSemillas) {
    if (semilla < 1) {
      print("Error en semilla");
      return -1;
    }
    if (multiplicador < 1) {
      print("Error en multiplicador");
      return -1;
    }
    if (constante < 1) {
      print("Error en constante aditiva");
      return -1;
    }
    if (modulo < semilla || modulo < multiplicador || modulo < constante) {
      print(
          "El modulo tiene que ser mayor que la semilla, el multiplicador y la constante aditiva");
      return -1;
    }
    List<double> semillas = [];
    semillas.add(semilla);
    for (var i = 0; i < numeroSemillas - 1; i++)
      semillas.add(
          ((semillas[semillas.length - 1] * multiplicador) + constante) %
              modulo);
    return semillas;
  }

// ----------------------------------------------------------------------------------------------------------

//Metodo para saber el periodo de repeticion de numeros generados aleatorios

  int repeticion(List numeros) {
    int veces = 0;
    for (var i = 0; i < numeros.length; i++) {
      for (var j = 0; j < numeros.length; j++) {
        if (numeros[i] == numeros[j]) {
          veces++;
        }
        if (veces == 2) return j - i;
      }
    }
    return 0;
  }

// ----------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------

//Metodo de pruebas corridas arriba y abajo

  corridasArribaAbajo(List<double> numeros) {
    int totalNumeros = numeros.length;
    List<int> bits = [];
    int bit;
    int corridas = 1;
    double media, varianza, z;

    //Variables con datos determinados
    final double confianza = .95;
    double alfa = 1 - confianza;
    double zn;

    for (var i = 0; i < totalNumeros; i++) {
      int next = i - 1;
      if (i == 0) next = totalNumeros - 1;
      if (numeros[i] <= numeros[next]) {
        bits.add(0);
      } else {
        bits.add(1);
      }
    }

    bit = bits[0];
    for (var i = 0; i < bits.length; i++) {
      if (bits[i] != bit) {
        corridas++;
        bit = bits[i];
      }
    }
    media = (2 * totalNumeros - 1) / 3.0;
    print("Media: " + media.toString());
    varianza = (16 * totalNumeros - 29) / 90.0;
    print("Varianza: " + varianza.toString());
    z = ((corridas - media) / sqrt(varianza)).abs();
    print("Z: " + z.toString());
    print(
        '---------------------------------------------------------------------------------------------------------------------------');
    zn = Normal.quantile(1 - alfa / 2);

    if (z < zn) {
      return ("No se rechaza que son independientes. ");
    } else {
      return ("No Pasa la prueba de corridas");
    }
  }

//LIst de files in a path
  listFiles(String path) async{
    String directory;
    List file = new List();
      directory = (await getApplicationDocumentsDirectory()).path;
      file = io.Directory("$directory/$path/")
          .listSync(); //use your folder name insted of resume.
    return file;
  }
}

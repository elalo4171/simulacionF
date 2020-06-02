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
    if (
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
        if (veces >= 2) return j - i;
      }
      veces=0;
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
      return true;
      // ("No se rechaza que son independientes. ");
    } else {
      return false;
      // ("No Pasa la prueba de corridas");
    }
  }

// ----------------------------------------------------------------------------------------------------------


//List de files in a path
  listFiles(String path) async{
    String directory;
    List file = new List();
      directory = (await getApplicationDocumentsDirectory()).path;
      file = io.Directory("$directory/$path/")
          .listSync(); 
    return file;
  }
// ----------------------------------------------------------------------------------------------------------


// List<double> _alfa=[0.10,0.05,0.01];
// List<int> _size=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,25,30,35,40,50,60,70,80,90,100];
// List<List<double>> _ks=[
//         [0.950,0.975,0.995],
//         [0.776,0.842,0.929],
//         [0.642,0.975,0.995],
//         [0.564,0.842,0.929],
//         [0.510,0.708,0.829],
//         [0.470,0.624,0.734],
//         [0.438,0.563,0.669],
//         [0.411,0.521,0.618],
//         [0.388,0.486,0.577],
//         [0.368,0.457,0.543],
//         [0.352,0.432,0.514],
//         [0.338,0.409,0.486],
//         [0.352,0.391,0.468],
//         [0.338,0.375,0.450],
//         [0.352,0.361,0.433],
//         [0.314,0.349,0.418],
//         [0.304,0.338,0.404],
//         [0.295,0.328,0.392],
//         [0.286,0.318,0.381],
//         [0.278,0.309,0.371],
//         [0.272,0.294,0.352],
//         [0.264,0.264,0.317],
//         [0.240,0.242,0.290],
//         [0.220,0.230,0.270],
//         [0.210,0.210,0.252],
//         [0.000,0.188,0.226],
//         [0.000,0.172,0.207],
//         [0.000,0.160,0.192],
//         [0.000,0.150,0.180],
//         [0.000,0.040,0.141],
//         [0.000,0.134,0.000],
// ];

//   kolmo(double alfa, int size){
//     int posx=0, posy=0;
//     double estadistico=0;

//     if(size<=100){
//       for (int i = 0; i < _alfa.length; i++) {
//                 if (_alfa[i] == alfa) {
//                     posx = i;
//                 }
//             }
//             for (int i = 0; i < _size.length; i++) {
//                 if (_size[i] == size) {
//                     posy = i;
//                 }
//             }
//             if (posx == 0 || posy == 0) {
//                 estadistico = -1;
//             }
//             estadistico =  _ks[posx][posy];
//     }else{
//        if(alfa == 0.1){
//                 estadistico = (1.22/sqrt(size));
//             }
//             if(alfa == 0.05){
//                 estadistico = (1.36/sqrt(size));
//             }
//             if(alfa == 0.01){
//                 estadistico = (1.63/sqrt(size));
//             }

//     }
//     return estadistico;

//   }

// ----------------------------------------------------------------------------------------------------------


  List<double> _numerosKolmogorov = [];

  get numerosKolmogorov => _aleatoriosMultiplicativo;

  set numerosKolmogorov(List<double> numeros) {
    _numerosKolmogorov = numeros;
    notifyListeners();
  }

// ----------------------------------------------------------------------------------------------------------
  bool getKolmogorov(){
    return _pruebaKolmogorov(_numerosKolmogorov);
  }

// ----------------------------------------------------------------------------------------------------------


       bool _pruebaKolmogorov(List<double > numeros){
        List vect;
        List dM,d;
        double Xi=0,j=1;
         double mayor;
        vect = List();
        dM= List();
        d = List();
        for (int i = 0; i < numeros.length; i++) {
            vect.add(numeros[i]);
             
        }
        vect.sort();
        for (int i = 0; i < vect.length; i++) {
            
            Xi= vect[i];
            double aux= j/vect.length;
            dM.add((aux)-Xi);
            d.add(Xi-((j-1)/vect.length));
            j++;
        }
        
        double mayorD,mayord;
        mayorD=dM[0];
        mayord=d[0];
        for(int i=0;i<dM.length;i++){
            if(dM[i] > mayorD){
                mayorD= dM[i];
            }
        }
        for(int i=0;i<d.length;i++){
            if(d[i] > mayord){
                mayord = d[i];
            }
        }
        
        if(mayorD>mayord){
            mayor = mayorD;
        }else{
            mayor = mayord;
        }
        double dnHipotesis = 1.36/sqrt(vect.length);
        if(mayor<=dnHipotesis){
         return true;
        //  "Prueba de Kolmogorov: Se acepta la hipotesis de que los numeros tienen una distribucion uniforme";
        }else 
            return  false;
            // "Prueba de Kolmogorov: Se rechaza la hipotesis de que los numeros tienen una distribucion uniforme";
        
    }

<<<<<<< HEAD
    bool _triangularInversa (List<double> list) {

=======
 getTi(){
    return tiNormal(_numerosKolmogorov);
 }

    tiNormal(List numeros){
      List<double> numerosOk=[];
        double miu=calcularMiu(numeros);
        double sigma=calcularDesviacion(numeros, miu);
        for (var numero in numeros) {

          double x = numero * sigma - miu + sigma;
          numerosOk.add(x);
          print(x);
        }
        return numerosOk;
    }

       double calcularMiu(List<double> numeros) {
       return (numeros.reduce((a, b) => a+b))/numeros.length;
    }

     double calcularDesviacion(List<double> numeros, double miu) {
       double sum=0;
       for (var i = 0; i < numeros.length; i++) {
         sum+=pow(numeros[i]-miu, 2);
       }
       return sum/numeros.length;
>>>>>>> 6c4aef06f9449192b539b18e0f887a10e7a2257d
    }


}




import 'package:flutter/material.dart';


class  GeneradorAleatorios with ChangeNotifier{

  List<double> _aleatoriosAdictivo=[];

  get numerosAleatorios=> _aleatoriosAdictivo;

  set numerosAleatorios(List numeros){
    _aleatoriosAdictivo=numeros;
    notifyListeners();
  }

  generarAdictivo(List<double> semillas, int modulo, int numero_semillas){
    if(semillas.length<=2){
      print(semillas.length);
      print("Problemas con las semillas");
    return -1;
    } 
    if(modulo%2!=0) {
      print("Problema con el modulo");
      return -1;}
    List<double> semillasTemporales=[];
    semillasTemporales= semillas;
    for (var i = 0; i < numero_semillas; i++) {
      double suma= semillasTemporales[i]+semillasTemporales[semillasTemporales.length-1];
      double conModulo=suma%100;
      semillasTemporales.add(conModulo);
    }
    return semillasTemporales;
  }


}



import 'package:flutter/material.dart';


class  GeneradorAleatorios with ChangeNotifier{

  List<double> aleatoriosAdictivo=[];



  generar_adictivo(List<double> semillas, int modulo, int numero_semillas){
    if(semillas.length<=2) return -1;
    if(modulo%2!=0) return -1;
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
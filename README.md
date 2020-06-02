# Simulación

Se presenta una aplicación móvil desarrollada en el lenguaje de programación Dart con el framework Flutter para el desarrollo de aplicaciones móviles, la aplicación trata de presentar el proyecto final de la materia de simulación generando números aleatorios.
![Pantalla de inicio de la App](https://github.com/elalo4171/simulacionF/blob/master/images/inicio.png)


# Tutorial

1.- Generar números pseudoaleatorio
-
En este caso nosotros utilizaremos el metodo mixto, vamos a inicio > click en botón "mixto"

![Mixto](https://github.com/elalo4171/simulacionF/blob/master/images/mixto.png)

2.- Ingresamos las variables necesarias en este caso 
 - 
 - Semilla : 5
 - Variable multiplicativa : 81
 - Cantidad de semillas a generar: 100 
 - Constante Aditiva: 89
 - Modulo: 100

![](https://github.com/elalo4171/simulacionF/blob/master/images/mixtoLleno.png)

3 .- Guardamos los números en memoria
- 
Damos click en "generar" y nos dara el resultado de las operaciones en la siguiente ventana podremos escojer entre guardar los numeros en un archivo de memoria, generar otros numeros o ir al inicio en este caso daremos en guardar el cual tambien despliega un mensaje de confirmacion en la parte inferior de la ventana.

![enter image description here](https://github.com/elalo4171/simulacionF/blob/master/images/numerosGuardados.png)

4.- Hacemos la prueba de corridas
-
- Seleccionamos los numeros en los cuales queremos hacer la prueba en este caso los almacenados en memoria

![](https://github.com/elalo4171/simulacionF/blob/master/images/corridas.png)

- Nos dira si paso o no la prueba 

![](https://github.com/elalo4171/simulacionF/blob/master/images/resultadosCorridas.png)

5.- Hacemos el proceso con Kolmogorov 
-
Nos regresara si paso o no la prueba 

![](https://github.com/elalo4171/simulacionF/blob/master/images/kolmo.png)

6.- Ejecutamos el proceso de Ajuste de transformada inversa
-
Al dar Tap nos mostrara una lista con nuestros números aleatorios generados y la opcion de guardarlos en memoria, volver al menú o al incio

![](https://github.com/elalo4171/simulacionF/blob/master/images/resultadostransformada.png)

 


# Generar numeros con el metodo congruencial adictivo

~~~~
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
  ~~~~

 En este metodo primero que nada se verifican los datos de entrada, las semillas, el modulo despues calculamos los numeros en un ciclo for usando el modulo, la primera y ultima semillas.
# Generar numeros con el metodo congruencial multiplicativo

~~~
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
    if (modulo % 2 == 0) {
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

~~~
 Este metodo es muy parecido al anterior al igual que en el anterior en un ciclo for se generan cada numero.
# Generar numeros con el metodo congruencial mixto

~~~
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
  ~~~


 Este metodo es muy parecido al anterior al igual que en el anterior en un ciclo for se generan cada numero.
 # Metodo para calcular el periodo de repeticion

~~~
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
~~~

Este metodo lo usamo para calcular el periodo de repeticion de una lista de numeros generados
# Metodo de corridas arriba y abajo

~~~
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
~~~
# Metodo para ver los archivos guardados

~~~
listFiles(String path) async{
    String directory;
    List file = new List();
      directory = (await getApplicationDocumentsDirectory()).path;
      file = io.Directory("$directory/$path/")
          .listSync(); 
    return file;
  }
~~~
# Metodo para hacer la preuba kolmogorov

~~~
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
 ~~~
 # Metodos para calcular la media y la desvicaion estandar

~~~
       double calcularMiu(List<double> numeros) {
       return (numeros.reduce((a, b) => a+b))/numeros.length;
    }



 double calcularDesviacion(List<double> numeros, double miu) {
       double sum=0;
       for (var i = 0; i < numeros.length; i++) {
         sum+=pow(numeros[i]-miu, 2);
       }
       return sum/numeros.length;
    }
 ~~~

# Metodos para calcular la transformada inversa 


~~~
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
~~~

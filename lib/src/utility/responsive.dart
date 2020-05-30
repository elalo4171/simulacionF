import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
 
 class Responsive{

   double width,height,ip;


   Responsive(BuildContext context){
     final size= MediaQuery.of(context).size;

     width= size.width;
     height= size.height;

     ip= math.sqrt(math.pow(width, 2)+ math.pow(height, 2));
   }
 }
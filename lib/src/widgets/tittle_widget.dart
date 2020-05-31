

import 'package:flutter/material.dart';
import 'package:simulacion/src/utility/responsive.dart';

ListTile title(String title, String subtitle, TextStyle styleTitle, Responsive _responsive){
  return ListTile(
    title: Text(title, style: styleTitle,),
    subtitle: Container(
          padding: EdgeInsets.only(left: _responsive.width * .02),
          child: Text(subtitle)),
  );
}
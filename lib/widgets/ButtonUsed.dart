import 'package:flutter/material.dart';

class ButtonUsed extends StatelessWidget {
String text;
void Function()? onTap;
ButtonUsed({Key? key,this.onTap, required this.text}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child:  Center(
          child: Text(

            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ChatMassage extends StatelessWidget {
  String? text;
  late Direction direction ;

  ChatMassage({Key? key,required this.text,
    required this.direction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment:(direction==Direction.right)? CrossAxisAlignment.start:CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Text(' $text ',style: const TextStyle(color: Colors.white)),
            decoration: BoxDecoration(
                color:(direction==Direction.right)?  const Color(0xff2B475E):Colors.indigo,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomRight:(direction==Direction.right)? const Radius.circular(15): const Radius.circular(0) ,
                  bottomLeft:(direction==Direction.left)? const Radius.circular(15): const Radius.circular(0) ,
                )),
          ),
        ],
      ),
    );
  }
}
enum Direction{
  right,
  left,
}
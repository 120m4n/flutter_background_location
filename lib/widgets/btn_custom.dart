import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class MyButton extends StatelessWidget {
  // const MyButton({super.key});

  final Color color;
  final int numero;
  final double ancho;
  final double alto;

  const MyButton(this.color, this.numero, this.ancho, this.alto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho,
      height: alto,
      // color: color,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
      decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Center(
        child: Text(numero.toString(),
            style: const TextStyle(
              fontSize: 30,
            )),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final VoidCallback callback; // Notice the variable type

  const Button(this.text, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 180,
      // child: FittedBox(
      //   fit: BoxFit.fitHeight,
      child: ElevatedButton(
        onPressed: callback, // Simply put the function name here, DON'T use ()
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
        ),
        child: Text(text),
      ),
      // )
    );
  }
}

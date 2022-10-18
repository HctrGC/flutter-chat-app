import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final String pregunta;
  final String accion;

  const Labels({
    super.key, 
    required this.ruta,
    required this.pregunta,
    required this.accion
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            pregunta,
            style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(
              accion, 
              style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.bold)
            )
          )
        ]
      )
    );
  }
}
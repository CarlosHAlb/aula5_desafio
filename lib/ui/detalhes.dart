import 'dart:io';

import 'package:flutter/material.dart';

import '../models/caminhada.dart';

class DetalhesScreen extends StatelessWidget {
  final Caminhada caminhada;

  const DetalhesScreen({super.key, required this.caminhada});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(caminhada.titulo),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
      ),
      backgroundColor: colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (caminhada.fotoPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(caminhada.fotoPath!),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              "Distância: ${caminhada.distancia.toStringAsFixed(0)} m",
              style: TextStyle(color: colorScheme.onSurface),
            ),
            Text(
              "Calorias: ${caminhada.calorias.toStringAsFixed(0)} kcal",
              style: TextStyle(color: colorScheme.onSurface),
            ),
            Text(
              "Tempo: ${caminhada.tempo.toStringAsFixed(0)} min",
              style: TextStyle(color: colorScheme.onSurface),
            ),
            Text(
              "Data: ${caminhada.data.toLocal().toString().substring(0, 16)}",
              style: TextStyle(color: colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

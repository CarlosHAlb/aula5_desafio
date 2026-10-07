import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/caminhada.dart';

class DetalhesScreen extends StatelessWidget {
  final Caminhada caminhada;

  const DetalhesScreen({
    super.key,
    required this.caminhada,
  });

  @override
  Widget build(BuildContext context) {
    const azul = Colors.blue;

    // Ponto inicial
    final origem = LatLng(-22.713, -46.818);

    // Ponto final de exemplo
    final destino = LatLng(-22.710, -46.812);

    return Scaffold(
      appBar: AppBar(
        title: Text(caminhada.titulo),
        backgroundColor: azul,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
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
                style: const TextStyle(
                  color: azul,
                  fontSize: 16,
                ),
              ),

              Text(
                "Calorias: ${caminhada.calorias.toStringAsFixed(0)} kcal",
                style: const TextStyle(
                  color: azul,
                  fontSize: 16,
                ),
              ),

              Text(
                "Tempo: ${caminhada.tempo.toStringAsFixed(0)} min",
                style: const TextStyle(
                  color: azul,
                  fontSize: 16,
                ),
              ),

              Text(
                "Data: ${caminhada.data.toLocal().toString().substring(0, 16)}",
                style: const TextStyle(
                  color: azul,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Percurso",
                style: TextStyle(
                  color: azul,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: origem,
                      initialZoom: 14,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.caminhadas',
                      ),

                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: [
                              origem,
                              destino,
                            ],
                            strokeWidth: 5,
                            color: Colors.blue,
                          ),
                        ],
                      ),

                      MarkerLayer(
                        markers: [
                          Marker(
                            point: origem,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),

                          Marker(
                            point: destino,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.flag,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
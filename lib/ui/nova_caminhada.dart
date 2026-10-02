import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';

import '../services/storage_service.dart';
import '../services/location_service.dart';
import '../models/caminhada.dart';

class NovaCaminhadaScreen extends StatefulWidget {
  const NovaCaminhadaScreen({super.key});

  @override
  State<NovaCaminhadaScreen> createState() => _NovaCaminhadaScreenState();
}

class _NovaCaminhadaScreenState extends State<NovaCaminhadaScreen> {
  LatLng origem = LatLng(-22.713, -46.818);
  LatLng? destino;

  double distancia = 0;
  double calorias = 0;
  double tempo = 0;

  File? imagem;

  final StorageService storage = StorageService();
  final LocationService location = LocationService();

  void calcular() {
    if (destino == null) return;

    distancia = location.calcularDistancia(origem, destino!);
    calorias = location.calcularCalorias(distancia);
    tempo = location.calcularTempo(distancia);

    setState(() {});
  }

  Future<void> tirarFoto() async {
    final picker = ImagePicker();

    final foto = await picker.pickImage(source: ImageSource.camera);

    if (foto != null && mounted) {
      setState(() {
        imagem = File(foto.path);
      });
    }
  }

  Future<void> salvar() async {
    final tituloController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text("Título da caminhada"),
        content: TextField(controller: tituloController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final caminhada = Caminhada(
                titulo: tituloController.text,
                distancia: distancia,
                calorias: calorias,
                tempo: tempo,
                data: DateTime.now(),
                fotoPath: imagem?.path,
              );

              await storage.salvarCaminhada(caminhada);

              if (!mounted) return;

              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );

    tituloController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Caminhada"),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        elevation: 0,
      ),
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: origem,
                initialZoom: 15,
                onTap: (tapPosition, latLng) {
                  destino = latLng;
                  calcular();
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.caminhadas',
                ),
                if (destino != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: origem,
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.location_on,
                          color: colorScheme.primary,
                          size: 40,
                        ),
                      ),
                      Marker(
                        point: destino!,
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.flag,
                          color: colorScheme.secondary,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (destino != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Vai percorrer ${distancia.toStringAsFixed(0)} m, "
                    "queimando cerca de "
                    "${calorias.toStringAsFixed(0)} calorias "
                    "em aproximadamente "
                    "${tempo.toStringAsFixed(0)} min.",
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 10),
                  if (imagem != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        imagem!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: tirarFoto,
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    label: const Text(
                      "Tirar Foto",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Salvar Caminhada",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

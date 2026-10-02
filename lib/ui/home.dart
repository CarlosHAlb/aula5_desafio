import 'dart:io';

import 'package:flutter/material.dart';

import '../models/caminhada.dart';
import '../services/storage_service.dart';
import 'nova_caminhada.dart';
import '../widgets/drawer_menu.dart';
import 'detalhes.dart';

class Home extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const Home({super.key, required this.onToggleTheme});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final StorageService storage = StorageService();
  List<Caminhada> caminhadas = [];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final lista = await storage.carregarCaminhadas();
    setState(() => caminhadas = lista);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Caminhadas'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        elevation: 0,
      ),
      drawer: DrawerMenu(onToggleTheme: widget.onToggleTheme),
      backgroundColor: colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: caminhadas.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final c = caminhadas[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalhesScreen(caminhada: c),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outline),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    c.fotoPath == null
                        ? Icon(
                            Icons.photo,
                            size: 60,
                            color: colorScheme.primary,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(c.fotoPath!),
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                    const SizedBox(height: 8),
                    Text(
                      c.titulo,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NovaCaminhadaScreen()),
          );
          carregar();
        },
      ),
    );
  }
}

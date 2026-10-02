import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/caminhada.dart';

class StorageService {
  Future<void> salvarCaminhada(Caminhada caminhada) async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList('caminhadas') ?? [];
    lista.add(jsonEncode(caminhada.toJson()));
    await prefs.setStringList('caminhadas', lista);
  }

  Future<List<Caminhada>> carregarCaminhadas() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList('caminhadas') ?? [];
    return lista.map((e) => Caminhada.fromJson(jsonDecode(e))).toList();
  }
}

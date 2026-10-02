class Caminhada {
  final String titulo;
  final double distancia;
  final double calorias;
  final double tempo;
  String? fotoPath;
  final DateTime data;

  Caminhada({
    required this.titulo,
    required this.distancia,
    required this.calorias,
    required this.tempo,
    this.fotoPath,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'distancia': distancia,
        'calorias': calorias,
        'tempo': tempo,
        'fotoPath': fotoPath,
        'data': data.toIso8601String(),
      };

  factory Caminhada.fromJson(Map<String, dynamic> json) => Caminhada(
        titulo: json['titulo'],
        distancia: json['distancia'],
        calorias: json['calorias'],
        tempo: json['tempo'],
        fotoPath: json['fotoPath'],
        data: DateTime.parse(json['data']),
      );
}
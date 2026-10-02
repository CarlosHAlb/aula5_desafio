import 'package:latlong2/latlong.dart';

class LocationService {
  final Distance d = const Distance();

  double calcularDistancia(LatLng origem, LatLng destino) {
    return d.as(LengthUnit.Meter, origem, destino);
  }

  double calcularCalorias(double distancia) {
    return distancia * 0.05; // estimativa simples
  }

  double calcularTempo(double distancia) {
    return distancia / 83.33; // 5 km/h ≈ 83.33 m/min
  }
}

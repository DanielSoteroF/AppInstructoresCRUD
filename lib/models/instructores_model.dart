import 'package:instructores_app/helpers/sqlHelper.dart';

class Data {
  int? id;
  String nombre;
  String apellido;
  String email;
  String especialidad;
  String numero;
  String genero;
  String? image;
  Data({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.especialidad,
    required this.numero,
    required this.genero,
    this.image
  });

  Data.fromMap(Map<String,dynamic> map) :
    id = map[idColumn],
    nombre = map[nameColumn],
    apellido = map[lastnameColumn],
    email = map[emailColumn],
    especialidad = map[specialtyColumn],
        numero = map[phoneColumn],
    genero = map[generoColumn],
    image = map[imageColumn];


  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      nameColumn: nombre,
      lastnameColumn: apellido,
      emailColumn: email,
      specialtyColumn: especialidad,
      phoneColumn: numero,
      generoColumn: genero,
      imageColumn: image
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Data(id: $id, nombre: $nombre, apellido: $apellido, email: $email, especialidad: $especialidad, numero: $numero, genero: $genero, image: $image)';
  }

}

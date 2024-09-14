import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instructores_app/models/instructores_model.dart';
import 'package:image_picker/image_picker.dart';

class DataPage extends StatefulWidget {
  final Data? data;

  const DataPage({super.key, this.data});

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _generoController = TextEditingController();

  final _nameFocus = FocusNode();
  final _lastnameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _specialtyFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _generoFocus = FocusNode();

  late bool
  _instructorEdited = false;

  late Data _editData;

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      _editData = Data.fromMap(widget.data!.toMap());
      _nameController.text = _editData.nombre;
      _lastnameController.text = _editData.apellido;
      _emailController.text = _editData.email;
      _specialtyController.text = _editData.especialidad;
      _phoneController.text = _editData.numero;
      _generoController.text = _editData.genero;
    } else {
      _editData = Data(nombre: '', apellido: '', email: '', especialidad: '', numero: '', genero: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => await _requestPop() ?? false,
        child: Scaffold(
          backgroundColor: Color(0xFF2d3250),
          appBar: AppBar(
            backgroundColor: Color(0xFF2d3250),
            title: Text(_editData.nombre ?? "Nueva Data"),
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editData.nombre.isNotEmpty && _editData.nombre != null) {
                Navigator.pop(context, _editData);
              } else if (_editData.apellido.isNotEmpty &&
                  _editData.apellido != null) {
                Navigator.pop(context, _editData);
              } else if (_editData.email.isNotEmpty &&
                  _editData.email != null) {
                Navigator.pop(context, _editData);
              } else if (_editData.especialidad.isNotEmpty &&
                  _editData.especialidad != null) {
                Navigator.pop(context, _editData);
              } else if (_editData.numero.isNotEmpty &&
                  _editData.numero != null) {
                Navigator.pop(context, _editData);
              } else if (_editData.genero.isNotEmpty &&
                  _editData.genero != null) {
                Navigator.pop(context, _editData);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
                FocusScope.of(context).requestFocus(_lastnameFocus);
                FocusScope.of(context).requestFocus(_emailFocus);
                FocusScope.of(context).requestFocus(_specialtyFocus);
                FocusScope.of(context).requestFocus(_phoneFocus);
                FocusScope.of(context).requestFocus(_generoFocus);
              }
            },
            child: Icon(Icons.save, color: Colors.black),
            backgroundColor: Color(0xFFf9b17a),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      image: DecorationImage(
                        image: _editData.image != null
                            ? FileImage(File(_editData.image!))
                            : const AssetImage('images/user.png'),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),


                  onTap: () async {
                    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _editData.image = image.path;
                      });
                    }
                  },
                ),

                Container(
                  margin: const EdgeInsets.only(top: 10),
                ),

                TextField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                    style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Nombre",
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Color(0xFF424769),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF424769))
                      )
                  ),
                    onChanged: (text) {
                      _instructorEdited = true;
                      setState(() {
                        _editData.nombre = text;
                      });
                    }
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                ),
                TextField(
                    style: const TextStyle(color: Colors.white),
                  controller: _lastnameController,
                  focusNode: _lastnameFocus,
                  decoration: InputDecoration(
                    labelText: "Apellido",
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Color(0xFF424769),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF424769))
                      )
                  ),
                    onChanged: (text) {
                      _instructorEdited = true;
                      setState(() {
                        _editData.apellido = text;
                      });
                    }
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                ),
                TextField(
                    style: const TextStyle(color: Colors.white),
                  controller: _emailController,
                  focusNode: _emailFocus,
                  decoration: InputDecoration(
                    labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Color(0xFF424769),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF424769))
                      )
                  ),
                    onChanged: (text) {
                      _instructorEdited = true;
                      setState(() {
                        _editData.email = text;
                      });
                    }
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                ),
                TextField(
                    style: const TextStyle(color: Colors.white),
                  controller: _specialtyController,
                  focusNode: _specialtyFocus,
                  decoration: InputDecoration(
                    labelText: "Especialidad",
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Color(0xFF424769),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF424769))
                      )
                  ),
                    onChanged: (text) {
                      _instructorEdited = true;
                      setState(() {
                        _editData.especialidad = text;
                      });
                    }
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                ),
                TextField(
                    style: const TextStyle(color: Colors.white),
                  controller: _phoneController,
                  focusNode: _phoneFocus,
                  decoration: InputDecoration(
                    labelText: "Numero",
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Color(0xFF424769),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF424769))
                      )
                  ),
                    onChanged: (text) {
                      _instructorEdited = true;
                      setState(() {
                        _editData.numero = text;
                      });
                    }
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                ),
                TextField(
                    style: const TextStyle(color: Colors.white),
                  controller: _generoController,
                  focusNode: _generoFocus,
                  decoration: InputDecoration(
                    labelText: "Genero",
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Color(0xFF424769),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF424769))
                      )
                  ),
                  onChanged: (text) {
                    _instructorEdited = true;
                    setState(() {
                      _editData.genero = text;
                    });
                  }
                ),
              ],
            ),
          ),
        )
    );
  }

  Future<bool?> _requestPop() async {
    if (_instructorEdited) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('¿Desea salir sin guardar?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Sí'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
            ],
          );
        },
      );
    }
    return true;
  }
}

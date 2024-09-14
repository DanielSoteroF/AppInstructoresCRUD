import 'package:flutter/material.dart';
import 'dart:io';
import 'package:instructores_app/models/instructores_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instructores_app/helpers/sqlHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_page.dart';
import 'login_page.dart';

enum OrderOptions { orderaz, orderza }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlHelper sql = SqlHelper();
  List<Data> data = [];

  @override
  void initState() {
    super.initState();
    _getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3250),
      appBar: AppBar(
        backgroundColor: Color(0xFF2d3250),
        title: const Text('Instructores', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.logout),
          color: Colors.white,
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', false);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),

        actions: <Widget>[
          PopupMenuTheme(
            data: const PopupMenuThemeData(
              color: Colors.white,
            ),
            child: PopupMenuButton<OrderOptions>(
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                const PopupMenuItem<OrderOptions>(
                  value: OrderOptions.orderaz,
                  child: Text('Ordenar por A-Z'),
                ),
                const PopupMenuItem<OrderOptions>(
                  value: OrderOptions.orderza,
                  child: Text('Ordenar por Z-A'),
                ),
              ],
              onSelected: _sortList,
              icon: const Icon(Icons.sort, color: Colors.white),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDataPage(data: Data(nombre: '', apellido: '', email: '', especialidad: '', numero: '', genero: ''));
        },
        backgroundColor: Color(0xFFf9b17a),
        child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 30
        ),
      ),
      body: Stack(children: <Widget>[
        ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _dataCard(context, index);
          },
        ),
      ]),
    );
  }

  Widget _dataCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        color: Color(0xFF676F9d),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  ListTile(
                    title: Text(
                      '${data[index].nombre ?? ''} ${data[index].apellido ?? ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                      ),


                    subtitle: Text(
                      data[index].especialidad ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFf9b17a),
                          fontSize: 16,
                    ),
                    ),

                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(

                          //código para elegir una imagen de la galería u obtener la imagen predeterminada

                          image: data[index].image != null
                              ? FileImage(File(data[index].image!))
                              : AssetImage('images/user.png'),
                          fit: BoxFit.cover),
                        ),
                      ),
                    ),
                ],
              ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit, color: Color(0xFFf9b17a)),
                    onPressed: () {
                      // Implement your edit functionality here
                      _showDataPage(data: data[index]);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Color(0xFFf9b17a)),
                    onPressed: () {
                      // Implement your delete functionality here
                      sql.deleteData(data[index].id);
                      setState(() {
                        data.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          ),
        ),

      //LLAME A LA FUNCIÓN _showOptions PARA MOSTRAR MODAL DE BOOTOMSHEET

    );
  }

  void _showDataPage({required Data data}) async {
    final recData = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => DataPage(data: data)),
    );

    if (recData != null) {
      if (data.id != null) {
        await sql.updateData(recData);
      } else {
        await sql.insertData(recData);
      }
      _getAllData();
    }
  }

  void _getAllData() {
    sql.getData().then((list) {
      setState(() {
        data = list;
      });
    });
  }

  //ESTA TUNCCIÓN SE UTILIZA PARA ORDENAR DATOS POR NOMBRE
  void _sortList(OrderOptions result) {
    switch (result) {

      //PARA ORDENAR DE LA A A LA Z
      case OrderOptions.orderaz:
        data.sort((a, b) => a.nombre.compareTo(b.nombre));
        break;

    //PARA ORDENAR DE LA Z A LA A
        case OrderOptions.orderza:
          data.sort((a, b) => b.nombre.compareTo(a.nombre));
          break;
    }
    setState(() {});
  }
}

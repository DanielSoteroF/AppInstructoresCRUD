import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String defaultUsername = 'daniel';
  String defaultPassword = '123';

  @override
  void initState() {
    super.initState();
    _initializeDefaultUser();
    _checkLoginStatus();
  }

  _initializeDefaultUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username') == null) {
      prefs.setString('username', defaultUsername);
      prefs.setString('password', defaultPassword);
    }
  }

  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String username = prefs.getString('username') ?? '';
    if (isLoggedIn && username.isNotEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage()));
    }
  }

  _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedUsername = prefs.getString('username') ?? '';
    String storedPassword = prefs.getString('password') ?? '';

    if (_usernameController.text == storedUsername &&
        _passwordController.text == storedPassword) {
      prefs.setBool('isLoggedIn', true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              children: <Widget>[
                Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                Text(
                    'Usuario o contraseña incorrectos'
                ),
              ],
            ),
          )
      );
    }
  }

  _register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    prefs.setString('password', _passwordController.text);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Row(
              children: <Widget>[
                Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                Text(
                  'Usuario registrado exitosamente',
                ),
              ],
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3250),
      appBar: AppBar(
        backgroundColor: Color(0xFF2d3250),
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image.asset(
                'lib/img/icon_login.png',
                width: 200,
                height: 180,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Logueate para continuar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
            ),

            TextField(
              controller: _usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Usuario',
                  labelStyle: const TextStyle(color: Colors.white),
                  fillColor: Color(0xFF424769),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF424769))
                  )
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
            ),

            TextField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Colors.white),
                  fillColor: Color(0xFF424769),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF424769))
                  )
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Color(0xFFf9b17a),
                  ),
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Color(0xFFf9b17a),
                  ),
                  child: const Text('Registrar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
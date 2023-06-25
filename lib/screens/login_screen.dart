import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jadwel/fetcher.dart' as fetcher;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _studentID = '';
  String _password = '';
  bool _isObscure = true;
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        'https://statistics-scheduling-system-api-production.up.railway.app/api/authenticate');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': _studentID,
          'password': _password,
        }),
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final authority = fetcher.getClaims(response.body)['authority'];
        if (kDebugMode) {
          print("auth test: $authority");
        }
        if (authority.toString() == 'Student') {
          await prefs.setString('jwtToken', response.body);
          if (kDebugMode) {
            print(response.body);
          }
          if (mounted) {
            fetcher.resetData();
            Navigator.pushNamed(context, '/mainscreen');
          }
        } else {
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                title: const Text('You are not authorized'),
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          }
        }
      } else {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) => SimpleDialog(
              title: const Text('Student ID or Password is incorrect'),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildLogoSection(double screenHeight) {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Image.asset(
            'assets/images/JUST_JADWEL_logo.png',
          );
        },
      ),
    );
  }

  Widget _buildInputFieldsSection(BuildContext context, double screenHeight) {
    return Center(
      child: Container(
        height: screenHeight * 0.39,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: const Color(0xFFFEFEFE),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              spreadRadius: 5,
              blurRadius: 5,
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenHeight * 0.035,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ThemeData().colorScheme.copyWith(
                        primary: const Color(0xFF244863),
                      ),
                ),
                child: TextField(
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: '',
                    labelText: 'Student Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF323232),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _studentID = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenHeight * 0.035,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ThemeData().colorScheme.copyWith(
                        primary: const Color(0xFF244863),
                      ),
                ),
                child: TextField(
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF323232),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordVisibility,
                      child: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                    ),
                    prefixIcon: const Icon(
                      Icons.key_outlined,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: screenHeight * 0.07,
                    width: MediaQuery.of(context).size.width * 0.635,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF244863),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.09),
          _buildLogoSection(screenHeight),
          SizedBox(height: screenHeight * 0.02),
          _buildInputFieldsSection(context, screenHeight),
          SizedBox(height: screenHeight * 0.25),
        ],
      ),
    );
  }
}

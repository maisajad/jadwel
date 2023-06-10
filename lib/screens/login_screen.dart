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

  void _toggle() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
          ),
          // ignore: prefer_const_constructors
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Image.asset(
                  'assets/images/JUST_JADWEL_logo.png',
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),

          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.39,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.035,
                      right: MediaQuery.of(context).size.height * 0.035,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.035,
                      right: MediaQuery.of(context).size.height * 0.035,
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
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _toggle();
                            },
                            child: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator() // Show circular indicator if _isLoading is true
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.635,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading =
                                    true; // Set _isLoading to true when button is pressed
                              });

                              var url = Uri.parse(
                                  'http://localhost:8080/api/authenticate');

                              var response = await http.post(
                                url,
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  'user_id': _studentID,
                                  'password': _password,
                                }),
                              );

                              if (response.statusCode == 200) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                final authority = fetcher
                                    .getClaims(response.body)['authority'];
                                if (kDebugMode) {
                                  print("mmmmmmmmmmmmaisa$authority");
                                }
                                if (authority.toString() == 'Student') {
                                  await prefs.setString(
                                      'jwtToken', response.body);
                                  if (kDebugMode) {
                                    print(response.body);
                                  }
                                  if (!mounted) return;
                                  Navigator.pushNamed(context, '/mainscreen');
                                } else {
                                  if (!mounted) return;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        SimpleDialog(
                                      title:
                                          const Text('You are not authorized'),
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
                              } else {
                                if (!mounted) return;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      SimpleDialog(
                                    title: const Text(
                                        'Student ID or Password are icorrect'),
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
                              setState(() {
                                _isLoading = false;
                              });
                            },
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
        ],
      ),
    );
  }
}

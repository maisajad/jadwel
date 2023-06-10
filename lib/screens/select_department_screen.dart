import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jadwel/fetcher.dart' as fetcher;

import '../components/college.dart';
import '../components/department.dart';

class SelectDepartmentScreen extends StatefulWidget {
  const SelectDepartmentScreen({Key? key}) : super(key: key);

  @override
  State<SelectDepartmentScreen> createState() => _SelectDepartmentScreenState();
}

class _SelectDepartmentScreenState extends State<SelectDepartmentScreen> {
  College _selectedCollege = College(id: 0, name: '');
  Department _selectedDepartment = Department(id: 0, name: '', collegeName: '');

  List<DropdownMenuItem<Department>> departments = [];
  List<String> courses = [];
  List<DropdownMenuItem<College>> _colleges = [];
  bool _isCollegeSelected = false;
  bool _isDepartmentSelected = false;

  @override
  void initState() {
    super.initState();
    fetchColleges().then((colleges) {
      setState(() {
        _colleges = colleges
            .map((college) => DropdownMenuItem<College>(
                  value: college,
                  child: Text(college.name),
                ))
            .toList();
      });
    });
  }

  Future<List<College>> fetchColleges() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/collages'));

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => College.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load colleges');
    }
  }

  void _onCollegeChanged(College? value) {
    setState(() {
      _isCollegeSelected = true;
      _selectedCollege = value!;
      _selectedDepartment = Department(id: 0, name: '', collegeName: '');
      fetchDepartments(_selectedCollege.id).then((departments) {
        setState(() {
          this.departments = departments
              .map((department) => DropdownMenuItem<Department>(
                    value: department,
                    child: Text(department.name),
                  ))
              .toList();
        });
      });
    });
  }

  Future<List<Department>> fetchDepartments(int collegeId) async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/api/departments/$collegeId'));

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => Department.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load departments');
    }
  }

  void _onDepartmentChanged(Department? value) {
    _isDepartmentSelected = true;
    setState(() {
      _selectedDepartment = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    fetcher.selectedDays = args['days'];
    fetcher.selectedCourses = args['courses'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Suggest New Schedule',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  'Select College',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Color(0xFF323232)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xFF323232)),
                      elevation: 3,
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                      iconSize: 40,
                      alignment: Alignment.topLeft,
                      items: _colleges,
                      onChanged: _onCollegeChanged,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      hint: _isCollegeSelected
                          ? Text(
                              _selectedCollege.name,
                              style: const TextStyle(fontSize: 20),
                            )
                          : const Text(
                              'Select college',
                              style: TextStyle(fontSize: 20),
                            ),
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  'Select Department',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Color(0xFF323232)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xFF323232)),
                      elevation: 3,
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                      iconSize: 40,
                      alignment: Alignment.topLeft,
                      items: departments,
                      onChanged: _onDepartmentChanged,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      hint: _isDepartmentSelected
                          ? Text(
                              _selectedDepartment.name,
                              style: const TextStyle(fontSize: 20),
                            )
                          : const Text(
                              'Select Department',
                              style: TextStyle(fontSize: 20),
                            ),
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3C698B),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _selectedDepartment.id != 0
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/selectcourses',
                          arguments: {
                            'college': _selectedCollege,
                            'department': _selectedDepartment,
                            'days': fetcher.selectedDays,
                            'courses': fetcher.selectedCourses
                          },
                        );
                      }
                    : null,
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SelectDepartmentScreen extends StatefulWidget {
  const SelectDepartmentScreen({Key? key}) : super(key: key);

  @override
  State<SelectDepartmentScreen> createState() => _SelectDepartmentScreen();
}

class _SelectDepartmentScreen extends State<SelectDepartmentScreen> {
  String _selectedCollege = 'Select College';
  String _selectedDepartment = 'Select Department';

  List<DropdownMenuItem<String>> departments = [];
  List<String> courses = [];

  void _onCollegeChanged(String? value) {
    setState(() {
      _selectedCollege = value!;
      _selectedDepartment = 'Select Department';
      if (_selectedCollege == 'Medicine') {
        departments = [
          const DropdownMenuItem(
            value: 'Doctor Of Medicine',
            child: Text('Doctor Of Medicine'),
          ),
          const DropdownMenuItem(
            value: 'Public Health',
            child: Text('Public Health'),
          ),
          const DropdownMenuItem(
            value: 'Health Management And Policy',
            child: Text('Health Management And Policy'),
          ),
        ];
      } else if (_selectedCollege == 'Applied Medical Sciences') {
        departments = [
          const DropdownMenuItem(
            value: 'Paramedics',
            child: Text('Paramedics'),
          ),
          const DropdownMenuItem(
            value: 'Radiologic Technology',
            child: Text('Radiologic Technology'),
          ),
          const DropdownMenuItem(
            value: 'Medical Laboratory Sciences',
            child: Text('Medical Laboratory Sciences'),
          ),
          const DropdownMenuItem(
            value: 'Dental Technology',
            child: Text('Dental Technology'),
          ),
          const DropdownMenuItem(
            value: 'Allied Dental Sciences',
            child: Text('Allied Dental Sciences'),
          ),
          const DropdownMenuItem(
            value: 'Optometry',
            child: Text('Optometry'),
          ),
          const DropdownMenuItem(
            value: 'Physical Therapy',
            child: Text('Physical Therapy'),
          ),
          const DropdownMenuItem(
            value: 'Occupational Therapy',
            child: Text('Occupational Therapy'),
          ),
          const DropdownMenuItem(
            value: 'Audiology & Speech Pathology',
            child: Text('Audiology & Speech Pathology'),
          ),
          const DropdownMenuItem(
            value: 'Clinical Rehabilitation Science',
            child: Text('Clinical Rehabilitation Science'),
          ),
          const DropdownMenuItem(
            value: 'Respiratory  Therapy',
            child: Text('Respiratory  Therapy'),
          ),
          const DropdownMenuItem(
            value: 'Anesthesia Technology',
            child: Text('Anesthesia Technology'),
          ),
        ];
      } else if (_selectedCollege == 'Engineering') {
        departments = [
          const DropdownMenuItem(
            value: 'Chemical Engineering',
            child: Text('Chemical Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Civil Engineering',
            child: Text('Civil Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Electrical Engineering',
            child: Text('Electrical Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Mechanical Engineering',
            child: Text('Mechanical Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Biomedical Engineering',
            child: Text('Biomedical Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Industrial Engineering',
            child: Text('Industrial Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Aeronautical Engineering',
            child: Text('Aeronautical Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Nuclear Engineering',
            child: Text('Nuclear Engineering'),
          ),
        ];
      } else if (_selectedCollege == 'Pharmacy') {
        departments = [
          const DropdownMenuItem(
            value: 'Pharmacy',
            child: Text('Pharmacy'),
          ),
          const DropdownMenuItem(
            value: 'Doctor Of Pharmacy (Pharm D.)',
            child: Text('Doctor Of Pharmacy (Pharm D.)'),
          ),
        ];
      } else if (_selectedCollege == 'Nursing') {
        departments = [
          const DropdownMenuItem(
            value: 'Nursing',
            child: Text('Nursing'),
          ),
          const DropdownMenuItem(
            value: 'Midwifery',
            child: Text('Midwifery'),
          ),
        ];
      } else if (_selectedCollege == 'Dentistry') {
        departments = [
          const DropdownMenuItem(
            value: 'Dental Surgery',
            child: Text('Dental Surgery'),
          ),
        ];
      } else if (_selectedCollege == 'Agriculture') {
        departments = [
          const DropdownMenuItem(
            value: 'Animal Production',
            child: Text('Animal Production'),
          ),
          const DropdownMenuItem(
            value: 'Plant Production',
            child: Text('Plant Production'),
          ),
          const DropdownMenuItem(
            value: 'Nutrition & Food Technology',
            child: Text('Nutrition & Food Technology'),
          ),
          const DropdownMenuItem(
            value: 'Natural Resources & Environment',
            child: Text('Natural Resources & Environment'),
          ),
        ];
      } else if (_selectedCollege == 'Veterinary Medicine') {
        departments = [
          const DropdownMenuItem(
            value: 'Veterinary Medicine And Surgery',
            child: Text('Veterinary Medicine And Surgery'),
          ),
          const DropdownMenuItem(
            value: 'Veterinary Clinical Medicine',
            child: Text('Veterinary Clinical Medicine'),
          ),
        ];
      } else if (_selectedCollege == 'Computer & Information Technology') {
        departments = [
          const DropdownMenuItem(
            value: 'Computer Engineering',
            child: Text('Computer Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Computer Science',
            child: Text('Computer Science'),
          ),
          const DropdownMenuItem(
            value: 'Computer Information Systems',
            child: Text('Computer Information Systems'),
          ),
          const DropdownMenuItem(
            value: 'Network Engineering And Security',
            child: Text('Network Engineering And Security'),
          ),
          const DropdownMenuItem(
            value: 'Software Engineering',
            child: Text('Software Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Cybersecurity',
            child: Text('Cybersecurity'),
          ),
          const DropdownMenuItem(
            value: 'Data Science',
            child: Text('Data Science'),
          ),
          const DropdownMenuItem(
            value: 'Artifcial Intelligence',
            child: Text('Artifcial Intelligence'),
          ),
        ];
      } else if (_selectedCollege == 'Martial Sciences') {
        departments = [
          const DropdownMenuItem(
            value: 'Military',
            child: Text('Military'),
          ),
        ];
      } else if (_selectedCollege == 'Science & Arts') {
        departments = [
          const DropdownMenuItem(
            value: 'Arabic Language',
            child: Text('Arabic Language'),
          ),
          const DropdownMenuItem(
            value: 'English Language & Linguistics',
            child: Text('English Language & Linguistics'),
          ),
          const DropdownMenuItem(
            value: 'Humanities',
            child: Text('Humanities'),
          ),
          const DropdownMenuItem(
            value: 'Mathematics',
            child: Text('Mathematics'),
          ),
          const DropdownMenuItem(
            value: 'Chemistry',
            child: Text('Chemistry'),
          ),
          const DropdownMenuItem(
            value: 'Physics',
            child: Text('Physics'),
          ),
          const DropdownMenuItem(
            value: 'Applied Biological Sciences',
            child: Text('Applied Biological Sciences'),
          ),
          const DropdownMenuItem(
            value: 'Biotechnology & Genetic Engineering',
            child: Text('Biotechnology & Genetic Engineering'),
          ),
          const DropdownMenuItem(
            value: 'Environmental Sciences',
            child: Text('Environmental Sciences'),
          ),
        ];
      } else if (_selectedCollege == 'Language Center') {
        departments = [
          const DropdownMenuItem(
            value: 'Language Center',
            child: Text('Language Center'),
          ),
        ];
      } else if (_selectedCollege == 'Institute Of Nanotechnology') {
        departments = [
          const DropdownMenuItem(
            value: 'Nanotechnology And Engineering',
            child: Text('Nanotechnology And Engineering'),
          ),
        ];
      } else if (_selectedCollege == 'Architecture And Design') {
        departments = [
          const DropdownMenuItem(
            value: 'Urban Planning & Studies',
            child: Text('Urban Planning & Studies'),
          ),
          const DropdownMenuItem(
            value: 'Architecture',
            child: Text('Architecture'),
          ),
          const DropdownMenuItem(
            value: 'Design And Visual Communication',
            child: Text('Design And Visual Communication'),
          ),
        ];
      } else {}
    });
  }

  void _onDepartmentChanged(String? value) {
    setState(() {
      _selectedDepartment = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C698B),
        title: const Text(
          'Suggest New Schedule',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
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
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xFF323232)),
                    elevation: 3,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                    iconSize: 40,
                    alignment: Alignment.topLeft,
                    items: const [
                      DropdownMenuItem(
                        value: 'Medicine',
                        child: Text('Medicine'),
                      ),
                      DropdownMenuItem(
                        value: 'Applied Medical Sciences',
                        child: Text('Applied Medical Sciences'),
                      ),
                      DropdownMenuItem(
                        value: 'Engineering',
                        child: Text('Engineering'),
                      ),
                      DropdownMenuItem(
                        value: 'Pharmacy',
                        child: Text('Pharmacy'),
                      ),
                      DropdownMenuItem(
                        value: 'Nursing',
                        child: Text('Nursing'),
                      ),
                      DropdownMenuItem(
                        value: 'Dentistry',
                        child: Text('Dentistry'),
                      ),
                      DropdownMenuItem(
                        value: 'Agriculture',
                        child: Text('Agriculture'),
                      ),
                      DropdownMenuItem(
                        value: 'Veterinary Medicine',
                        child: Text('Veterinary Medicine'),
                      ),
                      DropdownMenuItem(
                        value: 'Computer & Information Technology',
                        child: Text('Computer & Information Technology'),
                      ),
                      DropdownMenuItem(
                        value: 'Martial Sciences',
                        child: Text('Martial Sciences'),
                      ),
                      DropdownMenuItem(
                        value: 'Science & Arts',
                        child: Text('Science & Arts'),
                      ),
                      DropdownMenuItem(
                        value: 'Language Center',
                        child: Text('Language Center'),
                      ),
                      DropdownMenuItem(
                        value: 'Institute Of Nanotechnology',
                        child: Text('Institute Of Nanotechnology'),
                      ),
                      DropdownMenuItem(
                        value: 'Architecture And Design',
                        child: Text('Architecture And Design'),
                      ),
                    ],
                    onChanged: _onCollegeChanged,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: Text(
                      ' $_selectedCollege',
                      style: const TextStyle(fontSize: 20),
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
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xFF323232)),
                    elevation: 3,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                    iconSize: 40,
                    alignment: Alignment.topLeft,
                    items: departments,
                    onChanged: _onDepartmentChanged,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: Text(
                      ' $_selectedDepartment',
                      style: const TextStyle(fontSize: 20),
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
                primary: const Color(0xFF3C698B),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _selectedDepartment != 'Select Department'
                  ? () {
                      Navigator.pushNamed(
                        context,
                        '/selectcourses',
                        arguments: {
                          'college': _selectedCollege,
                          'department': _selectedDepartment,
                          'days': days,
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
    );
  }
}

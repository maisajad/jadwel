import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  /*const CustomCard({
    Key? key,
  }) : super(key: key);*/

  const CustomCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.width,
    required this.height,
  });
  final Widget icon;
  final VoidCallback onTap;
  final Text title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: InkWell(
        splashColor: Color.fromARGB(255, 195, 218, 236),
        onTap: onTap,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Color(0xFF3C698B),
                height: height / 13,
                width: width,
              ),
              SizedBox(
                height: height / 8,
              ),
              icon,
              title,
            ],
          ),
        ),
      ),
    );
  }
}

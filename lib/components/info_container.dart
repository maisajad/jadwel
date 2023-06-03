import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key? key,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconData,
    required this.title,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Color backgroundColor;
  final Color borderColor;
  final IconData iconData;
  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      height: height,
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            height: height,
            width: width / 70,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Center(
            child: Icon(
              iconData,
              color: borderColor,
            ),
          ),
          SizedBox(
            width: width / 30, // width / 70
          ),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: borderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

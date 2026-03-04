import 'package:flutter/material.dart';
import 'package:app_flutter_exam/models/constants.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    Key? key,
    required this.value,
    required this.text,
    required this.unit,
    required this.imageUrl,
  }) : super(key: key);

  final int value;
  final String text;
  final String unit;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Constants.textColor(context).withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Constants.isDark(context)
                ? const Color(0xff2a2a4a)
                : const Color(0xffE0E8FB),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(height: 8),
        Text(
          '${value.toString()}$unit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Constants.textColor(context),
          ),
        )
      ],
    );
  }
}
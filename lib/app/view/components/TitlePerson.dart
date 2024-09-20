import 'package:flutter/material.dart';

class TitlePerson extends StatelessWidget {
  const TitlePerson(this.text,{super.key,this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

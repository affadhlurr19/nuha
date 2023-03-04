import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:nuha/app/constant/styles.dart';

class FieldFincheck extends StatelessWidget {
  final String labelText;

  const FieldFincheck({Key? key, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: grey900,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 44,
          child: TextField(
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              // prefixIcon: FaIcon(FontAwesomeIcons.rupiahSign),
              // prefixIconConstraints: BoxConstraints(
              //   maxHeight: 16,
              //   maxWidth: 16,
              // ),
              suffixIcon: Icon(Icons.info_outline_rounded),
              hintText: "0",
              labelStyle: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w200, color: grey500),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(color: grey100, width: 1),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

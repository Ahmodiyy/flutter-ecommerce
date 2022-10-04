import 'package:flutter/material.dart';

const constantActionColor = Color(0xff5056B7);
// const constantNavColor = Color(0xff9C9B9C);
// const constantTextStyleLight = TextStyle(
//   color: constantNavColor,
//   fontWeight: FontWeight.bold,
// );

const constantTextStyleRed = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
);
const constantSizedBoxLarge = SizedBox(
  height: 40,
);
const constantSizedBoxMedium = SizedBox(
  height: 15,
);
const constantSizedBoxSmall = SizedBox(
  height: 10,
);
const constantSecondary = Color(0xffE6E5E8);
const constantTextFieldDecoration = InputDecoration(
  labelText: 'Email',
  hintText: 'Email address',
  fillColor: constantSecondary,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(
      15,
    )),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff4349CF), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(
      15,
    )),
  ),
);

const constantBoxMedium = SizedBox(
  width: 20,
);

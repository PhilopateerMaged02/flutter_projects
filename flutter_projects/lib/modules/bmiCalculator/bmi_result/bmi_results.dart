import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiResults extends StatelessWidget
{
   final int result ;
   final int height ;
   final int age ;
   final bool gender;
   final int weight;
   BmiResults({
     required this.age,
     required this.height,
     required this.gender,
     required this.result,
     required this.weight
 });
   //BmiResults b = BmiResults(age: 20, height: 180, gender: 'Male', result: 500.5);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('BMI Result',
        style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${gender ? 'Male' : 'Female'}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Age : $age',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Weight : $weight',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Height : $height',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Result : $result',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
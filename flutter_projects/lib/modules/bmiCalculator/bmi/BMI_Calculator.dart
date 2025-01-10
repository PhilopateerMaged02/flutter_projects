import 'dart:math';

import 'package:news_app/modules/bmiCalculator/bmi_result/bmi_results.dart';
//import 'package:news_app/modules/bmi_result/bmi_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMI extends StatefulWidget
{
  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  bool isMale = true;
  double height = 120.0;
  int weight = 70;
  int age = 10;
@override
  void initState()
  {
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      //backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
            'BMI CALCULATOR',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: ()
                        {
                          setState(() {
                          });
                          isMale = true;
                        },
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  image:AssetImage('assets/images/male.png'),
                                height: 90,
                                width: 90,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'MALE',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isMale ? Colors.blue : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: GestureDetector(
                        onTap: ()
                        {
                          setState(() {

                          });
                          isMale = false;
                        },
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image:AssetImage('assets/images/female.png'),
                                height: 90,
                                width: 90,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'FEMALE',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: !isMale ? Colors.blue : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                      ),
              ),

            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[400],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HEIGHT',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${height.round()}',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'cm',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                      Slider(
                          value: height,
                          max: 220,
                          min: 80,
                          activeColor: Colors.blue,
                          onChanged:(value)
                          {
                            setState(() {
                              height = value;
                            });
                            //print(value.round());
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AGE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),),
                            Text(
                              '${age}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'age+--',
                                  mini: true,
                                    onPressed: ()
                                    {
                                      setState(() {
                                      });
                                      age--;
                                    },
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),),
                                FloatingActionButton(
                                  heroTag: 'age+=',
                                  mini: true,
                                  onPressed: ()
                                  {
                                    setState(() {
                                    });
                                    age++;
                                  },
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'WEIGHT',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),),
                            Text(
                              '${weight}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'age-',
                                  mini: true,
                                  onPressed: ()
                                  {
                                    setState(() {
                                    });
                                    weight--;
                                  },
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),),
                                FloatingActionButton(
                                  heroTag: 'age+',
                                  mini: true,
                                  onPressed: ()
                                  {
                                    setState(() {
                                    });
                                    weight++;
                                  },
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.blue,
                height: 50,
                onPressed: ()
                {
                   double result = weight / pow(height/100, 2);
                  Navigator.push(
                    context,
                  MaterialPageRoute(
                      builder: (context)
                      {
                        return BmiResults(
                          height: height.round(),
                          age: age,
                          gender: isMale,
                          result: result.round(),
                          weight: weight,
                        );
                      })
                  );
                },
                child: Text('Calculate',
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
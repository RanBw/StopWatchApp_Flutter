// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StopWatchApp(),
    );
  }
}

class StopWatchApp extends StatefulWidget {
  const StopWatchApp({super.key});

  @override
  State<StopWatchApp> createState() => _StopWatchAppState();
}

class _StopWatchAppState extends State<StopWatchApp> {
  late Timer repetedTimer;
//نضيف duration بحيث تسمح لنا بالتحكم فيها بداخل الميثود ونقدر نجيب من الثواني -> الدقائق والساعات
  Duration duration = Duration(seconds: 0);
//نضيف متغير بوول بحيث اقدر من خلاله اظهر ال cancel , stop timer buttons
  bool isRunning = false;
  bool isStopped = false;

  increasingTime() {
    repetedTimer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        int newSeconds = duration.inSeconds + 1;

        duration = Duration(seconds: newSeconds);
      });
    });

    //OLD WAY ليست عملية !!
    //     int hours = 0;
    // int minutes = 0;
    // int seconds = 0;
    // Timer.periodic(Duration(hours: 1), (timer) {
    //   setState(() {
    //     hours++;
    //   });
    // });
    // Timer.periodic(Duration(minutes: 1), (timer) {
    //   setState(() {
    //     minutes++;
    //     if (minutes == 60) {
    //       minutes = 0;
    //     }
    //   });
    // });
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     seconds++;
    //     if (seconds == 60) {
    //       seconds = 0;
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 34, 37),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Stop Watch App",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      duration.inHours.toString().padLeft(2, "0"),
                      style: TextStyle(fontSize: 40),
                    )),
                    margin: EdgeInsets.all(11),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Hours",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      duration.inMinutes
                          .remainder(60)
                          .toString()
                          .padLeft(2, "0"),
                      style: TextStyle(fontSize: 40),
                    )),
                    margin: EdgeInsets.all(11),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Minutes",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      duration.inSeconds
                          .remainder(60)
                          .toString()
                          .padLeft(2, "0"),
                      style: TextStyle(fontSize: 40),
                    )),
                    margin: EdgeInsets.all(11),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Seconds",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          isRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // based on value in isStopped variable we show the button if the value is -> true we show the Resume button and if false we show Stop Timer button
                    isStopped
                        ? ElevatedButton(
                            onPressed: () {
                              // in resume button we first call the increasingTime Function and then we change the value of isStopped variable to false so Stop Timer shows up
                              increasingTime();

                              setState(() {
                                isStopped = false;
                              });
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "Resume",
                                  style: TextStyle(fontSize: 20),
                                )),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11))),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              //Stop the timer + make isStopped  variable to -> true so Resume button shows up

                              repetedTimer.cancel();

                              setState(() {
                                isStopped = true;
                              });
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "Stop Timer",
                                  style: TextStyle(fontSize: 20),
                                )),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11))),
                          ),
                    SizedBox(
                      width: 22,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //اوقف التايمر + اني اخلي ال duration كلها ب اصفار
                        repetedTimer.cancel();
                        setState(() {
                          duration = Duration(seconds: 0);
                          isRunning = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11))),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    increasingTime();
                    isRunning = true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Start Timer",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11))),
                ),
        ],
      ),
    );
  }
}

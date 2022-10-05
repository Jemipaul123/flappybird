import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/images/barrier.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class HomePage extends StatefulWidget {
  @override
_HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {

  double time= 0;
  double height=0;
  double initialHeight=birdYaxis;
  static double birdYaxis = 0;
  bool gameHasStarted = false;
  static double barrierXone =1;
  double barrierXtwo = barrierXone + 1.5;
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;

    });
    }

    void startGame(){
    gameHasStarted = true;
     Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });



         setState(() {
           if (barrierXone< -2) {
             barrierXone += 3.0;
           }
           else{barrierXone-= 0.05;
           }
         });
      setState(() {
        if (barrierXtwo< -2) {
          barrierXtwo += 3.0;
        }
        else{barrierXtwo-= 0.05;
        }
      });

      if (birdYaxis >1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });

    }

@override
Widget build(BuildContext context) {
 return GestureDetector(
   onTap: () {

     if (gameHasStarted) {
         jump();
       } else {
         startGame();
       }
     },

   child:Scaffold(
  body: Column(
  children: [
       Expanded(
    flex:2,
    child: Stack(
      children: [
        AnimatedContainer(
            alignment: Alignment(0,birdYaxis),
            duration:Duration(milliseconds: 0),
            color: Colors.orange,
            child: MyBird(),
          ),
       Container(
          alignment: Alignment(0,-0.3),
          child: gameHasStarted
            ? Text("")
            :  Text("T A P  T O  P L A Y",style: TextStyle(color: Colors.black87, fontSize:25)),
        ),
       AnimatedContainer(
         alignment: Alignment(barrierXone,1.1),
         duration: Duration(milliseconds:0),
         child: MyBarrier(
           size:200.0,
         ),
       ),
        AnimatedContainer(
          alignment: Alignment(barrierXone,-1.7),
        duration: Duration(milliseconds: 0),
          child:MyBarrier(
            size:200.0,
          ),
        ),
        AnimatedContainer(
          alignment: Alignment(barrierXtwo,1.9),
          duration: Duration(milliseconds: 0),
          child:MyBarrier(
            size:200.0,
          ),
        ),
        AnimatedContainer(
          alignment: Alignment(barrierXtwo,-1.2),
          duration: Duration(milliseconds: 0),
          child:MyBarrier(
            size:200.0,
          ),
        ),
      ],
    ),
),
Container(
  height: 15,
  color: Colors.green,
),
Expanded(
  child:Container(
     color: Colors.brown,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("SCORE ",style: TextStyle(color: Colors.black87, fontSize:25)),
                SizedBox(height: 20,),
                Text("0",style: TextStyle(color: Colors.black87, fontSize:40)),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("     BEST",style: TextStyle(color: Colors.black87, fontSize:25)),
        SizedBox(height: 20,),
        Text("  10",style: TextStyle(color: Colors.black87, fontSize:40)),
      ],
),
 ],
),
),
  ),
   ],
  ),
   ),
);
}
}

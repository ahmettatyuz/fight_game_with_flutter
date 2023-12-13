import 'package:fight_game/main.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key, required this.winner, required this.playerNumber});
  final String winner;
  final int playerNumber;
  @override
  Widget build(BuildContext context) {
    String mesaj = "";
    if (playerNumber == 1) {
      mesaj = "1. Oyuncu Kazandı !";
    } else {
      mesaj = "2. Oyuncu Kazandı !";
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login.jpg"),
                  fit: BoxFit.none,
                  scale: 0.7,
                  alignment: Alignment.bottomCenter),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mesaj,
                      style: TextStyle(fontSize: 30),
                    ),
                    Image.asset('assets/images/$winner.png',scale: 1.1,),
                    ElevatedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>const MyApp()));
                    }, child: const Text("Tekrar Oyna"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

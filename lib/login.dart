import 'package:fight_game/game.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String gameTitle = "1. Oyuncu Seçimi";
  int secimSirasi = 1;
  bool warriorSecilebilir = true;
  bool wizardSecilebilir = true;
  bool defenderSecilebilir = true;

  String warriorText = "";
  String defenderText = "";
  String wizardText = "";
  String player1type = "";
  String player2type = "";
  @override
  Widget build(BuildContext context) {
    if (secimSirasi != 3) {
      gameTitle = "$secimSirasi. Oyuncu Seçimi";
    } else {
      gameTitle = "Oyun Başlayabilir...";
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("FIGHT GAME",style: TextStyle(color: Colors.red,fontSize: 50,decoration: TextDecoration.underline ),),
              Text(
                gameTitle,
                style: const TextStyle(fontSize: 24),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (warriorSecilebilir) {
                        if (secimSirasi == 1) {
                          player1type = "warrior";
                          setState(() {
                            secimSirasi = 2;
                            warriorText = "1. Oyuncu";
                          });
                        } else if (secimSirasi == 2) {
                          player2type = "warrior";
                          setState(() {
                            warriorText = "2. Oyuncu";
                            secimSirasi = 3;
                          });
                        }
        
                        warriorSecilebilir = false;
                      }
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/warrior.png",
                          scale: 1.5,
                        ),
                        Text(
                          warriorText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (wizardSecilebilir) {
                        if (secimSirasi == 1) {
                          player1type = "wizard";
                          setState(() {
                            secimSirasi = 2;
                            wizardText = "1. Oyuncu";
                          });
                        } else if (secimSirasi == 2) {
                          player2type = "wizard";
                          setState(() {
                            wizardText = "2. Oyuncu";
                            secimSirasi = 3;
                          });
                        }
                        wizardSecilebilir = false;
                      }
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/wizard.png",
                          scale: 1.5,
                        ),
                        Text(
                          wizardText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (defenderSecilebilir) {
                        if (secimSirasi == 1) {
                          player1type = "defender";
                          setState(() {
                            secimSirasi = 2;
                            defenderText = "1. Oyuncu";
                          });
                        } else if (secimSirasi == 2) {
                          player2type = "defender";
                          setState(() {
                            defenderText = "2. Oyuncu";
                            secimSirasi = 3;
                          });
                        }
                        defenderSecilebilir = false;
                      }
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/defender.png",
                          scale: 1.5,
                        ),
                        Text(
                          defenderText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: secimSirasi == 3 ?  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return Game(player1type: player1type,player2type: player2type,);
                        },
                      ),
                    );
                  }:null,
                  child: const Text("Oyuna başla"))
            ],
          ),
        ),
      ],
    );
  }
}

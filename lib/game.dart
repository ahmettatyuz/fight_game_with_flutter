import 'package:fight_game/gameover.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math; // import this

class Game extends StatefulWidget {
  const Game({super.key, required this.player1type, required this.player2type});
  final String player1type;
  final String player2type;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  double progressValue1 = 1; 
  double progressValue2 = 1; 
  int saldiriSirasi = 1;
  double player1saldiri = 0;
  String player1resim = "";
  int player1savunma = 0;
  double player1iksir = 0;
  bool player1koruma = false;

  double player2saldiri = 0;
  String player2resim = "";
  int player2savunma = 0;
  double player2iksir = 0;
  bool player2koruma = false;

  Widget buildPlayerInfo(
      int playerNumber,
      double value,
      Color color,
      String playerName,
      String imagePath,
      double saldiri,
      int savunma,
      double can,
      bool koruma,
      bool aktif) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          playerName,
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            width: 150,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(height: 8),
        playerNumber == 2
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Image.asset(
                  imagePath,
                  scale: 2,
                ),
              )
            : Image.asset(
                imagePath,
                scale: 2,
              ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: aktif ? () {
                setState(() {
                  if (playerNumber == 1) {
                    progressValue2 = progressValue2 -
                        (player2koruma
                            ? saldiri - saldiri * player2savunma / 100
                            : saldiri);
                    player2koruma = false;
                    player2resim = 'assets/images/${widget.player2type}.png';
                  } else {
                    progressValue1 = progressValue1 -
                        (player1koruma
                            ? saldiri - saldiri * player1savunma / 100
                            : saldiri);
                    player1koruma = false;
                    player1resim = 'assets/images/${widget.player1type}.png';
                  }

                  saldiriSirasi = playerNumber == 1 ? 2 : 1;
                });
              }:null,
              child: const Text('Saldır'),
            ),
            ElevatedButton(
              onPressed: aktif && !koruma ? () {
                setState(() {
                  if (playerNumber == 1) {
                    player1resim =
                        'assets/images/${widget.player1type}protected.png';
                    player1koruma = true;
                  } else{
                    player2resim =
                        'assets/images/${widget.player2type}protected.png';
                    player2koruma = true;
                  }
                  saldiriSirasi = playerNumber == 1 ? 2 : 1;
                });
              }:null,
              child: const Text('Savun'),
            ),
            ElevatedButton(
              onPressed: can>0 && aktif ? () {
                setState(() {
                  if (playerNumber == 1) {
                    progressValue1 = progressValue1 + can;
                    progressValue1 = progressValue1 > 1 ? 1 : progressValue1;
                    player1iksir = 0;
                  } else {
                    progressValue2 = progressValue2 + can;
                    progressValue2 = progressValue2 > 1 ? 1 : progressValue2;
                    player2iksir = 0;
                  }
                  saldiriSirasi = playerNumber == 1 ? 2 : 1;
                  
                });
              }:null,
              child: const Text('Can İksiri İç'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.player1type == "warrior") {
      player1saldiri = 0.12;
      player1savunma = 50;
      player1iksir = 0.3;
    } else if (widget.player1type == "wizard") {
      player1saldiri = 0.1;
      player1savunma = 50;
      player1iksir = 0.45;
    } else if (widget.player1type == "defender") {
      player1saldiri = 0.1;
      player1savunma = 75;
      player1iksir = 0.3;
    }
    player1resim = 'assets/images/${widget.player1type}.png';
    if (widget.player2type == "warrior") {
      player2saldiri = 0.13;
      player2savunma = 50;
      player2iksir = 0.3;
    } else if (widget.player2type == "wizard") {
      player2saldiri = 0.1;
      player2savunma = 50;
      player2iksir = 0.45;
    } else if (widget.player2type == "defender") {
      player2saldiri = 0.1;
      player2savunma = 75;
      player2iksir = 0.3;
    }
    player2resim = 'assets/images/${widget.player2type}.png';
  }

  @override
  Widget build(BuildContext context) {
    if (progressValue1 <= 0) {
      return GameOver(
        winner: widget.player2type,
        playerNumber: 2,
      );
    } else if (progressValue2 <= 0) {
      return GameOver(
        winner: widget.player1type,
        playerNumber: 1,
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/arena.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildPlayerInfo(
                        1,
                        progressValue1,
                        Colors.blue,
                        'Oyuncu 1',
                        player1resim,
                        player1saldiri,
                        player1savunma,
                        player1iksir,
                        player1koruma,
                        saldiriSirasi == 1),
                  ),
                  Expanded(
                    child: buildPlayerInfo(
                        2,
                        progressValue2,
                        Colors.green,
                        'Oyuncu 2',
                        player2resim,
                        player2saldiri,
                        player2savunma,
                        player2iksir,
                        player2koruma,
                        saldiriSirasi == 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

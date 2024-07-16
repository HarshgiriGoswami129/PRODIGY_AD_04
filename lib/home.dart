import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<List<String>> _gameBoard;
  late bool _isPlayer1Turn;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _gameBoard = List.generate(3, (_) => List.filled(3, ''));
    _isPlayer1Turn = true;
    _gameOver = false;
  }

  void _playMove(int row, int col) {
    if (!_gameOver && _gameBoard[row][col].isEmpty) {
      setState(() {
        _gameBoard[row][col] = _isPlayer1Turn ? 'X' : 'O';
        _checkForWinner(row, col);
        _isPlayer1Turn = !_isPlayer1Turn;
      });
    }
  }

  void _checkForWinner(int row, int col) {
    String playerSymbol = _gameBoard[row][col];
    bool won = false;

    // Check row
    if (_gameBoard[row].every((symbol) => symbol == playerSymbol)) {
      won = true;
    }

    // Check column
    if (!_gameBoard.any((row) => row[col] != playerSymbol)) {
      won = true;
    }

    // Check diagonals
    if ((row == col ||
        row + col == _gameBoard.length - 1) &&
        (_gameBoard[0][0] == playerSymbol &&
            _gameBoard[1][1] == playerSymbol &&
            _gameBoard[2][2] == playerSymbol ||
            (_gameBoard[0][2] == playerSymbol &&
                _gameBoard[1][1] == playerSymbol &&
                _gameBoard[2][0] == playerSymbol))) {
      won = true;
    }

    if (won) {
      setState(() {
        _gameOver = true;
      });
    }
  }

  void _resetGame() {
    setState(() {
      _initializeBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () => _playMove(row, col),
                  child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        _gameBoard[row][col],
                        style: TextStyle(fontSize: 50.0, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            _gameOver
                ? ElevatedButton(
              onPressed: _resetGame,
              child: Text('Start New Game'),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

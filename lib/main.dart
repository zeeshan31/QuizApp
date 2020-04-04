import 'package:flutter/material.dart';
import 'package:quiz/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quiz());

class Quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<Icon> scoreKeeper = [];

  void checkanswer(bool userinput) {
    setState(() {
      if (quizBrain.finish() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        quizBrain.reset();

        scoreKeeper = [];
      } else {
        if (quizBrain.getteranswer() == userinput)
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        else
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
          quizBrain.setNumber();
      }
    });
  }

  QuizBrain quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text('Quiz Time'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Text(
                        quizBrain.getter(),
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton(
                        color: Colors.green,
                        child: Text(
                          'True',
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                        ),
                        onPressed: () {
                          checkanswer(true);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton(
                        color: Colors.red,
                        child: Text(
                          'Flase',
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                        ),
                        onPressed: () {
                          checkanswer(false);
                        },
                      ),
                    ),
                  ),
                  Row(children: scoreKeeper),
                ],
              ),
            ),
          )),
    );
  }
}

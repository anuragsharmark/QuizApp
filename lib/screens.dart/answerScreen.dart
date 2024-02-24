import 'package:flutter/material.dart';
import 'package:quiz_app/questionsModal.dart';

class answerScreen extends StatelessWidget {
  answerScreen({super.key});

  final List<question> questionList = getquestionList();

  correctAnswer(answer answer, int index) {
    String result = '';
    if (answer.isCorrect) {
      result = answer.answerText;
    }
    return result;
  }

  questionAnswers(int index) {
    String correctAns = (questionList[index].answerList.map(
          (e) => correctAnswer(e, index),
        )).toString();

    for (int i = 0; i < 5; i++) {
      if (correctAns.startsWith('(') ||
          correctAns.startsWith(',') ||
          correctAns.startsWith(' ')) {
        correctAns = correctAns.substring(1);
      }
      if (correctAns.endsWith(')') ||
          correctAns.endsWith(',') ||
          correctAns.endsWith(' ')) {
        correctAns = correctAns.substring(0, correctAns.length - 1);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border:
              Border.all(width: 2.8, color: Color.fromRGBO(247, 164, 158, 1)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questionList[index].questionText,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                correctAns,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Answers :')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Answers :',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: questionList.length,
                itemBuilder: (context, index) {
                  return questionAnswers(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

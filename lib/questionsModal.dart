class question {
  final String questionText;
  final List<answer> answerList;

  question(this.questionText, this.answerList);
}

class answer {
  final String answerText;
  final bool isCorrect;

  answer(this.answerText, this.isCorrect);
}

List<question> getquestionList() {
  List<question> list = [];

  list.add(question('Which planet is known as the \"Red Planet\" ?', [
    answer('Venus', false),
    answer('Mars', true),
    answer('Jupiter', false),
    answer('Saturn', false),
  ]));
  list.add(question('Who painted the Mona Lisa?', [
    answer('Vincent van Gogh', false),
    answer('Leonardo da Vinci', true),
    answer('Pablo Picasso', false),
    answer('Michelangelo', false)
  ]));

  list.add(question('Which country is known as the "Land of the Rising Sun"?', [
    answer('China', false),
    answer('Japan', true),
    answer('South Korea', false),
    answer('Thailand', false)
  ]));

  list.add(question('Flutter uses dart as a language?',
      [answer('True', true), answer('False', false)]));

  list.add(question('What is the largest organ in the human body?', [
    answer('Heart', false),
    answer('Liver', false),
    answer('Skin', true),
    answer('Brain', false)
  ]));

  list.add(
      question('Which scientist formulated the theory of general relativity?', [
    answer('Isaac Newton', false),
    answer('Albert Einstein', true),
    answer('Galileo Galilei', false),
    answer('Stephen Hawking', false)
  ]));

  list.add(question('What is the capital of Australia?', [
    answer('Sydney', false),
    answer('Melbourne', false),
    answer('Canberra', true),
    answer('Brisbane', false)
  ]));

  return list;
}

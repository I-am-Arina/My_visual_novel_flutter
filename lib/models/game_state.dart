class GameState {
  String currentLabel;
  int index;
  bool ended;
  String? bgPath;
  int score;           // ← добавляем счётчик очков
  int maxScore;        // ← максимально возможное количество очков

  GameState({
    this.currentLabel = '',
    this.index = 0,
    this.ended = false,
    this.bgPath,
    this.score = 0,
    this.maxScore = 0,
  });

  // Вспомогательный метод для проверки, прошёл ли игрок
  bool hasGoodEnding() {
    // Хорошая концовка, если набрано больше половины очков
    return score > maxScore / 2;
  }
}
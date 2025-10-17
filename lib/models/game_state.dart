class GameState {
  String currentLabel;
  int index;
  String? bgPath;
  bool ended;

  GameState({
    this.currentLabel = 'intro',
    this.index = 0,
    this.bgPath,
    this.ended = false,
  });
}

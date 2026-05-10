sealed class Node {}

class BgNode extends Node {
  final String path;
  BgNode(this.path);
}

class MusicNode extends Node {
  final String path;
  MusicNode(this.path);
}

class SayNode extends Node {
  final String who;
  final String text;
  SayNode(this.who, this.text);
}

class ChoiceOption {
  final String text;
  final String jump;
  ChoiceOption({required this.text, required this.jump});
}

class ChoiceNode extends Node {
  final String prompt;
  final List<ChoiceOption> options;
  ChoiceNode(this.prompt, this.options);
}

class JumpNode extends Node {
  final String label;
  JumpNode(this.label);
}

class EndNode extends Node {}

class Scene {
  final String label;
  final List<Node> nodes;
  const Scene(this.label, this.nodes);
}

// Узел для добавления очков
class AddScoreNode implements Node {
  final int points;
  
  AddScoreNode(this.points);
}

// Узел для условного перехода (будет использоваться для проверки концовки)
class CondNode implements Node {
  final String condition;  // пока оставим строкой, но в идеале сделать парсер
  final String jumpIfTrue;
  final String? jumpIfFalse;
  
  CondNode(this.condition, this.jumpIfTrue, [this.jumpIfFalse]);
}
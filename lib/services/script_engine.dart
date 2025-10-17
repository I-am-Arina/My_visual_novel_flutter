import '../models/script_nodes.dart';
import '../models/game_state.dart';

class ScriptEngine {
  final Map<String, Scene> _scenes;
  final GameState state;
  void Function(String path)? onMusic;

  ScriptEngine(this._scenes, this.state, {this.onMusic});

  Scene get _scene => _scenes[state.currentLabel]!;

  Node? get currentNode =>
      (state.index >= 0 && state.index < _scene.nodes.length)
          ? _scene.nodes[state.index]
          : null;

  void _jump(String label) {
    state.currentLabel = label;
    state.index = 0;
  }

  bool next() {
    if (state.ended) return false;
    final node = currentNode;
    if (node == null) {
      state.ended = true;
      return false;
    }

    switch (node) {
      case BgNode n:
        state.bgPath = n.path;
        state.index++;
        return next();
      case MusicNode n:
        onMusic?.call(n.path);
        state.index++;
        return next();
      case SayNode _:
        return true;
      case ChoiceNode _:
        return true;
      case JumpNode n:
        _jump(n.label);
        return next();
      case EndNode _:
        state.ended = true;
        return false;
    }
  }

  void advanceDialogue() {
    if (currentNode is SayNode) {
      state.index++;
      next();
    }
  }

  void choose(int i) {
    final node = currentNode;
    if (node is! ChoiceNode) return;
    if (i < 0 || i >= node.options.length) return;
    final opt = node.options[i];
    _jump(opt.jump);
    next();
  }
}
